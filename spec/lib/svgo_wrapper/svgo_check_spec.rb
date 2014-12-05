require "spec_helper"

describe SvgoWrapper do
  subject { described_class }

  it "finds the `svgo` tool in the current system" do
    expect(subject.svgo_present?).to be(true)
  end

  context "`svgo` tool does not exist" do
    before(:each) do
      allow(Open4).to receive(:spawn).and_raise
    end

    it "does not find the `svgo` tool in the current system" do
      expect(subject.svgo_present?).to be(false)
    end
  end
end
