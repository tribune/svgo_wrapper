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
end
