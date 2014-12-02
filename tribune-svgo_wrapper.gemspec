# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tribune/svgo_wrapper/version'

Gem::Specification.new do |spec|
  spec.name          = "tribune-svgo_wrapper"
  spec.version       = Tribune::SvgoWrapper::VERSION
  spec.authors       = ["gdeoliveira"]
  spec.email         = ["gdeoliveira@tribune.com"]
  spec.summary       = %q{Write a short summary. Required.}
  spec.description   = %q{Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end
