require "svgo_wrapper/svgo_check"
require "svgo_wrapper/version"

module SvgoWrapper
  unless svgo_present?
    warn <<-EOS
WARNING: Required tool `svgo` not found on the system.
         Please follow these instructions to install it: https://github.com/svg/svgo#how-to-use
    EOS
  end
end
