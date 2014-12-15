# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "finstyle/version"

Gem::Specification.new do |spec|
  spec.name           = "finstyle"
  spec.version        = Finstyle::VERSION
  spec.authors        = ["Fletcher Nichol"]
  spec.email          = ["fnichol@nichol.ca"]
  spec.summary        = "Version pinning RuboCop and configuration for " \
                        "consistentcy in CI"
  spec.description    = spec.description
  spec.homepage       = "http://fnichol.github.io/finstyle"
  spec.license        = "MIT"

  spec.files          = `git ls-files -z`.split("\x0")
  spec.executables    = %w[finstyle finstyle-config]
  spec.test_files     = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths  = ["lib"]

  spec.required_ruby_version = ">= 1.9.3"

  spec.add_dependency("rubocop", "0.28.0")

  spec.add_development_dependency("bundler", "~> 1.6")
  spec.add_development_dependency("rake", "~> 10.0")
  spec.add_development_dependency("countloc", "~> 0.4")

  # style and complexity libraries are tightly version pinned as newer releases
  # may introduce new and undesireable style choices which would be immediately
  # enforced in CI
  spec.add_development_dependency("cane", "2.6.2")
end
