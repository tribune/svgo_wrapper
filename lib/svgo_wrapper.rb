require "open4"

require "svgo_wrapper/constants"
require "svgo_wrapper/svgo_check"
require "svgo_wrapper/version"

class SvgoWrapper
  attr_reader :disabled_plugins, :enabled_plugins

  def initialize(enable: [], disable: [])
    self.enabled_plugins = filter_plugins(enable).freeze
    self.disabled_plugins = filter_plugins(disable).freeze
  end

  private

  attr_writer :disabled_plugins, :enabled_plugins

  def filter_plugins(plugins)
    VALID_PLUGINS & plugins.to_a.map(&:to_sym)
  end
end
