require "open4"

require "svgo_wrapper/constants"
require "svgo_wrapper/parser_error"
require "svgo_wrapper/svgo_check"
require "svgo_wrapper/version"

class SvgoWrapper
  attr_reader :disabled_plugins, :enabled_plugins, :timeout

  def initialize(enable: nil, disable: nil, timeout: DEFAULT_TIMEOUT)
    self.enabled_plugins = filter_plugins(Set[*enable]).freeze
    self.disabled_plugins = filter_plugins(Set[*disable]).freeze
    self.plugin_args = generate_plugin_args.freeze
    self.timeout = timeout
  end

  def optimize_images_data(data)
    Open4.spawn "svgo #{plugin_args} -i - -o -",
                stdin: data,
                stdout: output = "",
                stdout_timeout: timeout

    raise ParserError, output unless output.start_with? "<svg"
    output
  end

  def timeout=(value)
    @timeout = value.is_a?(Numeric) ? value : (@timeout || DEFAULT_TIMEOUT)
  end

  private

  # Eventually we might let users modify these. Not for now.
  attr_writer :disabled_plugins, :enabled_plugins
  attr_accessor :plugin_args

  def filter_plugins(plugins)
    VALID_PLUGINS & plugins.map(&:to_sym)
  end

  def generate_plugin_args
    (disabled_plugins.map {|v| "--disable=#{v}" } + enabled_plugins.map {|v| "--enable=#{v}" }) * " "
  end
end
