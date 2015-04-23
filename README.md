# Finstyle: Version Pinning RuboCop and Configuration for CI

[![Gem Version](https://badge.fury.io/rb/finstyle.svg)](http://badge.fury.io/rb/finstyle)
[![Build Status](https://travis-ci.org/fnichol/finstyle.svg?branch=master)](https://travis-ci.org/fnichol/finstyle)
[![Code Climate](https://codeclimate.com/github/fnichol/finstyle.png)](https://codeclimate.com/github/fnichol/finstyle)
[![Dependency Status](https://gemnasium.com/fnichol/finstyle.svg)](https://gemnasium.com/fnichol/finstyle)


This is an executable version of a Ruby style guide which uses [RuboCop][rubocop] as its implementation. It focuses on being Ruby code that is non-surprising, readable, and allows for some flexibility with respect to naming expression.

## How It Works

This library has a direct dependency on one specific version of RuboCop (at a time), and [patches it][patch] to load the [upstream configuration][upstream] and [custom set][config] of rule updates. When a new RuboCop release comes out, this library can rev its pinned version dependency and [re-vendor][rakefile] the upstream configuration to determine if any breaking style or lint rules were added/dropped/reversed/etc.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'finstyle'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install finstyle

## Usage

### Vanilla RuboCop

Run RuboCop as normal, simply add a `-r finstyle` option when running:

```sh
rubocop -r finstyle -D --format offenses
```

Alternatively, you can use the `finstyle-config` command to determine the path on disk to Finstyle's YAML config file:

```sh
rubocop --config $(finstyle-config) -D --format offenses
```

### finstyle Command

Use this tool just as you would RuboCop, but invoke the `finstyle` binary
instead which patches RuboCop to load rules from the Finstyle gem. For example:

```sh
finstyle -D --format offenses
```

### Rake

In a Rakefile, the setup is exactly the same, except you need to require the
Finstyle library first:

```ruby
require "finstyle"
require "rubocop/rake_task"
RuboCop::RakeTask.new do |task|
  task.options << "--display-cop-names"
end
```

### guard-rubocop

You can use one of two methods. The simplest is to add the `-r finstyle` option to the `:cli` option in your Guardfile:

```ruby
guard :rubocop, cli: "-r finstyle" do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
```

Alternatively you could pass the path to Finstyle's configuration by using the `Finstyle.config` method:

```ruby
require "finstyle"

guard :rubocop, cli: "--config #{Finstyle.config}" do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
```

### .rubocop.yml

As with vanilla RuboCop, any custom settings can still be placed in a `.rubocop.yml` file in the root of your project.

## Frequently Ask Questions

* **Why?**
  Tools and libraries such as RuboCop couple an implementation with policy into one versioned artifact. As such it can be hard to determine if a version change was due to a new tool feature or policy changes. Additonally, most users of such dependencies declare very loose version constraints on these tools (blindly depending on latest release or even assuming a SemVer friendly constraint such as `"~ 1.0"`). Then when a new version is released any continuous integration (CI) jobs may start to fail without *any* change in code. This library attempts to bake the version of the upstream dependency and its custom policy in one place. By the way, if you decide to use this library, it is recommended to version pin the version in your gemspec or Gemfile.
* **Aren't the default RuboCop rules sufficient?**
  The custom rules for Finstyle were derived by using a corpus of working production code and so the aim here is to be pragmatic and realistic.
* **I disagree with {{insert rule here}}, can I change it?**
  You are welcome to submit issues or pull requests to this project but keep in mind that as any style guides go, these work for the author and related projects. They weren't made arbitrarily :) If you like the implemementation (hack), feel free to fork/copy the idea and vendor your own custom rules.

## Contributing

* Source hosted at [GitHub][repo]
* Report issues/questions/feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make. For
example:


1. Fork it ( https://github.com/fnichol/finstyle/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Authors

Created and maintained by [Fletcher Nichol][fnichol] (<fnichol@nichol.ca>)

## License

MIT (see [LICENSE.txt][license])

[license]:      https://github.com/fnichol/finstyle/blob/master/LICENSE.txt
[fnichol]:      https://github.com/fnichol
[repo]:         https://github.com/fnichol/finstyle
[issues]:       https://github.com/fnichol/finstyle/issues
[contributors]: https://github.com/fnichol/finstyle/contributors

[config]:   https://github.com/fnichol/finstyle/blob/master/config/finstyle.yml
[rubocop]:  https://github.com/bbatsov/rubocop
[patch]:    https://github.com/fnichol/finstyle/blob/master/lib/finstyle.rb
[rakefile]: https://github.com/fnichol/finstyle/blob/master/Rakefile
[upstream]: https://github.com/fnichol/finstyle/blob/master/config/default.yml
