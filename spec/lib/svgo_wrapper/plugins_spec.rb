require "spec_helper"

describe SvgoWrapper::PLUGINS do
  it "contains safe names" do
    expect(subject).to all(match(/\A\w+\z/))
  end
end
