class SvgoWrapper
  class << self
    def svgo_present?
      response = `echo "<svg xmlns='http://www.w3.org/2000/svg'></svg>" | svgo -i - -o - 2> /dev/null`
      !(response =~ /\A<svg/).nil?
    end
  end

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
