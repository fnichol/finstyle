# -*- encoding: utf-8 -*-

require "bundler/gem_tasks"

upstream = Gem::Specification.find_by_name("rubocop")

desc "Vendor rubocop-#{upstream.version} configuration into gem"
task :vendor do
  src = Pathname.new(upstream.gem_dir).join("config")
  dst = Pathname.new(__FILE__).dirname.join("config")

  mkdir_p dst
  cp(src.join("default.yml"), dst.join("upstream.yml"))
  cp(src.join("enabled.yml"), dst.join("enabled.yml"))
  cp(src.join("disabled.yml"), dst.join("disabled.yml"))

  sh %{git add #{dst}/{upstream,enabled,disabled}.yml}
  sh %{git commit -m "Vendor rubocop-#{upstream.version} upstream configuration."}
end

desc "Display LOC stats"
task :stats do
  puts "\n## Production Code Stats"
  sh "countloc -r lib"
end

require "finstyle"
require "rubocop/rake_task"
RuboCop::RakeTask.new(:style) do |task|
  task.options << "--display-cop-names"
end

if RUBY_ENGINE != "jruby"
  require "cane/rake_task"
  desc "Run cane to check quality metrics"
  Cane::RakeTask.new do |cane|
    cane.canefile = "./.cane"
  end

  desc "Run all quality tasks"
  task :quality => [:cane, :style, :stats]
else
  desc "Run all quality tasks"
  task :quality => [:style, :stats]
end

task :default => [:quality]
