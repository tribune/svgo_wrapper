# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "svgo_wrapper/version"

Gem::Specification.new do |spec|
  spec.name = "svgo_wrapper"
  spec.required_ruby_version = ">= 2.1"
  spec.version = SvgoWrapper::VERSION
  spec.authors = ["Gabriel de Oliveira"]
  spec.email = ["gdeoliveira@tribune.com"]
  spec.summary = "This is a simple wrapper for Kir Belevich's `svgo` tool."
  spec.description = "This gem wraps the SVG image optimization tool by Kir Belevich (svgo).\n" \
                     "It supports enabling and disabling specific cleanup plugins before optimizing the image data."
  spec.homepage = "https://github.com/tribune/svgo_wrapper"
  spec.license = "MIT"
  spec.files = `git ls-files -z`.split("\x0")
  spec.test_files = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ["lib"]
  spec.post_install_message = "Please verify that the `svgo` tool is installed: https://github.com/svg/svgo#how-to-use"

  spec.add_dependency "open4", "~> 1.3.4"
end
