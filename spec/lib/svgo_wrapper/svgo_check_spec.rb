require "spec_helper"

describe SvgoWrapper do
  subject { described_class }

  it "finds the `svgo` tool in the current system" do
    expect(subject.svgo_present?).to be(true)
  end
end
