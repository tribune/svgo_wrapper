require "set"

require "open4"

require "svgo_wrapper/constants"
require "svgo_wrapper/error"
require "svgo_wrapper/parser_error"
require "svgo_wrapper/svgo_check"
require "svgo_wrapper/version"

class SvgoWrapper
  attr_reader :disabled_plugins, :enabled_plugins, :timeout

  def initialize(enable: nil, disable: nil, timeout: DEFAULT_TIMEOUT)
    self.enabled_plugins = enable
    self.disabled_plugins = disable
    self.plugin_args = generate_plugin_args(enabled: enabled_plugins, disabled: disabled_plugins)
    self.timeout = timeout
  end

  def optimize_images_data(data)
    begin
      Open4.spawn ["svgo", *plugin_args, "-i", "-", "-o", "-"],
                  stdin: data,
                  stdout: output = "",
                  stdout_timeout: timeout
    rescue Open4::SpawnError => e
      raise Error, "Unexpected error (#{e.exitstatus})\n"
    end

    verify_output(output)
    output
  end

  def timeout=(value)
    if value.is_a? Numeric
      @timeout = value
    elsif @timeout.nil?
      @timeout = DEFAULT_TIMEOUT
    end
  end

  private

  attr_accessor :plugin_args

  def disabled_plugins=(values)
    @disabled_plugins = filter_plugins(Set[*values]).freeze
  end

  def enabled_plugins=(values)
    @enabled_plugins = filter_plugins(Set[*values]).freeze
  end

  def filter_plugins(plugins)
    VALID_PLUGINS & plugins.map(&:to_sym)
  end

  def generate_plugin_args(enabled:, disabled:)
    (disabled.map {|v| "--disable=#{v}".freeze } +
     enabled.map {|v| "--enable=#{v}".freeze }).freeze
  end

  def verify_output(output)
    return if output =~ /<svg/

    output = "There was a problem optimizing the SVG image with the selected plugins\n" if output.strip.empty?
    raise ParserError, output
  end
end
