require "spec_helper"

describe SvgoWrapper::DEFAULT_TIMEOUT do
  it { is_expected.to be_a(Numeric) }
end
