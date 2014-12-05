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
    self.enabled_plugins = filter_plugins(Set[*enable]).freeze
    self.disabled_plugins = filter_plugins(Set[*disable]).freeze
    self.plugin_args = generate_plugin_args(enabled: enabled_plugins, disabled: disabled_plugins).freeze
    self.timeout = timeout
  end

  def optimize_images_data(data)
    begin
      Open4.spawn ["svgo", plugin_args, "-i", "-", "-o", "-"],
                  stdin: data,
                  stdout: output = "",
                  stdout_timeout: timeout
    rescue Open4::SpawnError => e
      raise Error, "Unexpected error (#{e.exitstatus})\n"
    end

    raise ParserError, output unless output.start_with? "<svg"
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

  # Eventually we might let users modify these. Not for now.
  attr_writer :disabled_plugins, :enabled_plugins
  attr_accessor :plugin_args

  def filter_plugins(plugins)
    VALID_PLUGINS & plugins.map(&:to_sym)
  end

  def generate_plugin_args(enabled:, disabled:)
    (disabled.map {|v| "--disable=#{v}" } +
     enabled.map {|v| "--enable=#{v}" }).flatten
  end
end
