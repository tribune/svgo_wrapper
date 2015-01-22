require "spec_helper"

describe SvgoWrapper do
  # The valid plugin sample consists of 3 existing plugins. The first and last ones are symbols, and the one in the
  # middle is a string.
  let(:sample_size) { 3 }
  let(:valid_plugins) do
    described_class::VALID_PLUGINS.to_a.sample(sample_size).map.with_index {|v, i| i.even? ? v : v.to_s }
  end
  let(:invalid_plugins) { valid_plugins + ["inv4lid", :plug1ns] }
  let(:valid_plugins_as_symbols) { valid_plugins.map(&:to_sym) }

  describe "valid_plugins" do
    subject { valid_plugins }

    it "consists of Symbols and Strings" do
      expect(subject.map(&:class)).to eq([Symbol, String, Symbol])
    end
  end

  describe "enabled plugins" do
    context "when none are passed" do
      subject { described_class.new.enabled_plugins }

      it { is_expected.to be_empty }
      it { is_expected.to be_frozen }
    end

    context "when valid are passed" do
      subject { described_class.new(enable: valid_plugins).enabled_plugins }

      it { is_expected.to be_frozen }
      it { is_expected.to contain_exactly(*valid_plugins_as_symbols) }
    end

    context "when invalid are passed" do
      subject { described_class.new(enable: invalid_plugins).enabled_plugins }

      it { is_expected.to be_frozen }
      it { is_expected.to contain_exactly(*valid_plugins_as_symbols) }
    end
  end

  describe "disabled plugins" do
    context "when none are passed" do
      subject { described_class.new.disabled_plugins }

      it { is_expected.to be_empty }
      it { is_expected.to be_frozen }
    end

    context "when valid are passed" do
      subject { described_class.new(disable: valid_plugins).disabled_plugins }

      it { is_expected.to be_frozen }
      it { is_expected.to contain_exactly(*valid_plugins_as_symbols) }
    end

    context "when invalid are passed" do
      subject { described_class.new(disable: invalid_plugins).disabled_plugins }

      it { is_expected.to be_frozen }
      it { is_expected.to contain_exactly(*valid_plugins_as_symbols) }
    end
  end

  describe "timeout" do
    let(:default_timeout) { described_class::DEFAULT_TIMEOUT }
    let(:valid_timeout) { 25.5 }
    let(:invalid_timeout) { :XVIII }

    context "when none is passed" do
      subject { described_class.new }

      it "has a default value" do
        expect(subject.timeout).to eq(default_timeout)
      end

      it "can set a new valid value" do
        subject.timeout = invalid_timeout
        expect(subject.timeout).to eq(default_timeout)
        subject.timeout = valid_timeout
        expect(subject.timeout).to eq(valid_timeout)
      end
    end

    context "when valid value is passed" do
      let(:valid_timeout_2) { 32 }

      subject { described_class.new(timeout: valid_timeout) }

      it "has that value set" do
        expect(subject.timeout).to eq(valid_timeout)
      end

      it "can set a new valid value" do
        subject.timeout = invalid_timeout
        expect(subject.timeout).to eq(valid_timeout)
        subject.timeout = valid_timeout_2
        expect(subject.timeout).to eq(valid_timeout_2)
      end
    end

    context "when invalid value is passed" do
      subject { described_class.new(timeout: invalid_timeout) }

      it "has a default value" do
        expect(subject.timeout).to eq(default_timeout)
      end

      it "can set a new valid value" do
        subject.timeout = invalid_timeout
        expect(subject.timeout).to eq(default_timeout)
        subject.timeout = valid_timeout
        expect(subject.timeout).to eq(valid_timeout)
      end
    end
  end

  describe "#optimize_images_data" do
    let(:svg_image) { " <svg><metadata>My Metadata</metadata><title>My Title</title></svg>" }

    context "without plugins" do
      subject { described_class.new.optimize_images_data svg_image }

      it { is_expected.to start_with("<svg") }
      it { is_expected.to end_with("/svg>\n") }
    end

    context "using plugins" do
      context "to remove the title and keep the metadata" do
        subject { described_class.new(enable: :removeTitle, disable: [:removeMetadata]).optimize_images_data svg_image }

        it { is_expected.to match(/My Metadata/) }
        it { is_expected.not_to match(/My Title/) }
      end

      context "to keep the title and remove the metadata" do
        subject { described_class.new(enable: [:removeMetadata], disable: :removeTitle).optimize_images_data svg_image }

        it { is_expected.to match(/My Title/) }
        it { is_expected.not_to match(/My Metadata/) }
      end
    end

    context "with incorrect data" do
      let(:invalid_svg_image) { " <svg><title>This is wrong...</svg>" }
      subject { described_class.new.optimize_images_data invalid_svg_image }

      it "raises a parsing error" do
        expect { subject }.to raise_error(described_class::ParserError, "Unexpected close tag\n")
      end
    end

    describe "`svgo` tool" do
      context "returns an empty string" do
        let(:svg_image) { " <svg/>" }

        subject { described_class.new(enable: :transformsWithOnePath).optimize_images_data svg_image }

        it "raises a descriptive exception" do
          expect { subject }.to raise_error(described_class::ParserError, "There was a problem optimizing the SVG " \
                                                                          "image with the selected plugins\n")
        end
      end

      context "unexpectedly fails" do
        let(:mocked_status) do
          # A mock of Process::Status
          Object.new.tap do |o|
            o.instance_eval do
              define_singleton_method :signaled?, proc { false }
              define_singleton_method :exitstatus, proc { 123 }
            end
          end
        end

        subject { described_class.new.optimize_images_data svg_image }

        before(:each) do
          allow(Open4).to receive(:spawn).and_raise(Open4::SpawnError.new("command example", mocked_status))
        end

        it "raises a general error" do
          expect { subject }.to raise_error(described_class::Error, "Unexpected error (123)\n")
        end
      end
    end
  end
end
