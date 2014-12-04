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
end
