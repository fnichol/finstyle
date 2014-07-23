# -*- encoding: utf-8 -*-

require "finstyle/version"
require "rubocop"

# Honestly, this is generally **not** a good idea and takes advantage of
# non-frozen strings being used for constant values upstream. Remember, with
# Ruby's great power comes great responsibility.

module RuboCop
  class ConfigLoader
    RUBOCOP_HOME.gsub!(
      /^.*$/,
      File.realpath(File.join(File.dirname(__FILE__), ".."))
    )

    DEFAULT_FILE.gsub!(
      /^.*$/,
      File.join(RUBOCOP_HOME, "config", "default.yml")
    )
  end
end

# Finstyle patches the RuboCop tool to set a new default configuration that
# is vendored in the Finstyle codebase.
module Finstyle
  # @return [String] the absolute path to the main RuboCop configuration YAML
  #   file
  def self.config
    RuboCop::ConfigLoader::DEFAULT_FILE
  end
end
