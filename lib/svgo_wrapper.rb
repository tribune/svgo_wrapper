require "svgo_wrapper/version"
require "svgo_wrapper/svgo_check"

class SvgoWrapper
  unless svgo_present?
    # We will warn the user once if the `svgo` tool isn't present on this system when the gem is required. This check
    # will not be performed again in the code for performance reasons.
    # :nocov:
    warn <<-EOS
WARNING: Required tool `svgo` not found on the system.
         Please follow these instructions to install it: https://github.com/svg/svgo#how-to-use
    EOS
    # :nocov:
  end
end
