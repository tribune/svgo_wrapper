$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'svgo_wrapper'

RSpec.configure do |config|
  config.color = true
  config.order = :rand
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
