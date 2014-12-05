# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "svgo_wrapper/version"

Gem::Specification.new do |spec|
  spec.name          = "tribune-svgo_wrapper"
  spec.version       = SvgoWrapper::VERSION
  spec.authors       = ["gdeoliveira"]
  spec.email         = ["gdeoliveira@tribune.com"]
  spec.summary       = "Simple `svgo` wrapper."
  spec.description   = "This is a simple wrapper for the `svgo` command line tool."
  spec.files         = [".gitignore", ".rubocop.yml", ".ruby-version", ".simplecov", ".travis.yml", "Gemfile",
                        "Guardfile", "README.md", "Rakefile", "lib/svgo_wrapper.rb", "lib/svgo_wrapper/constants.rb",
                        "lib/svgo_wrapper/error.rb", "lib/svgo_wrapper/parser_error.rb",
                        "lib/svgo_wrapper/svgo_check.rb", "lib/svgo_wrapper/version.rb",
                        "spec/lib/svgo_wrapper/constants_spec.rb", "spec/lib/svgo_wrapper/svgo_check_spec.rb",
                        "spec/lib/svgo_wrapper/version_spec.rb", "spec/lib/svgo_wrapper_spec.rb", "spec/spec_helper.rb",
                        "tasks/coverage.rb", "tribune-svgo_wrapper.gemspec"]
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ["lib"]

  spec.add_dependency "open4" # , "~> 1.3.4"
end
