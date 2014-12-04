require "open4"

require "svgo_wrapper/constants"
require "svgo_wrapper/svgo_check"
require "svgo_wrapper/version"

class SvgoWrapper
  attr_reader :disabled_plugins, :enabled_plugins, :timeout

  def initialize(enable: Set.new, disable: Set.new, timeout: DEFAULT_TIMEOUT)
    self.enabled_plugins = filter_plugins(enable).freeze
    self.disabled_plugins = filter_plugins(disable).freeze
    self.timeout = timeout
  end

  def optimize_images_data(data)
    Open4.spawn "svgo -i - -o -",
                stdin: data,
                stdout: output = "",
                stdout_timeout: timeout

    output
  end

  def timeout=(value)
    @timeout = value.is_a?(Numeric) ? value : (@timeout || DEFAULT_TIMEOUT)
  end

  private

  attr_writer :disabled_plugins, :enabled_plugins

  def filter_plugins(plugins)
    VALID_PLUGINS & plugins.map(&:to_sym)
  end
end
