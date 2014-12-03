require "spec_helper"

describe SvgoWrapper::DEFAULT_TIMEOUT do
  it { is_expected.to be_a(Numeric) }
end

describe SvgoWrapper::PLUGINS do
  it "contains safe names" do
    expect(subject).to all(match(/\A\w+\z/))
  end
end
