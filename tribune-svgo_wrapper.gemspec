# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "svgo_wrapper/version"

Gem::Specification.new do |spec|
  spec.name = "tribune-svgo_wrapper"
  spec.required_ruby_version = ">= 2.1"
  spec.version = SvgoWrapper::VERSION
  spec.authors = ["Gabriel de Oliveira"]
  spec.email = ["gdeoliveira@tribune.com"]
  spec.summary = "Simple `svgo` wrapper."
  spec.description = "This is a simple wrapper for the `svgo` command line tool."
  spec.files = `git ls-files -z`.split("\x0")
  spec.test_files = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ["lib"]

  spec.add_dependency "open4", "~> 1.3.4"
end
