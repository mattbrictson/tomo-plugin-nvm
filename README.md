# tomo-plugin-nvm

[![Gem Version](https://img.shields.io/gem/v/tomo-plugin-nvm)](https://rubygems.org/gems/tomo-plugin-nvm)
[![Gem Downloads](https://img.shields.io/gem/dt/tomo-plugin-nvm)](https://www.ruby-toolbox.com/projects/tomo-plugin-nvm)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/mattbrictson/tomo-plugin-nvm/ci.yml)](https://github.com/mattbrictson/tomo-plugin-nvm/actions/workflows/ci.yml)
[![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/mattbrictson/tomo-plugin-nvm)](https://codeclimate.com/github/mattbrictson/tomo-plugin-nvm)

This is a [tomo](https://github.com/mattbrictson/tomo) plugin to manage node and yarn via nvm (instead of using the [nodenv tasks](https://tomo.mattbrictson.com/plugins/nodenv/) that are built into tomo). The `nvm:install` task is a drop-in replacement for tomo’s `nodenv:install` task.

---

- [Installation](#installation)
- [Settings](#settings)
- [Tasks](#tasks)
- [Support](#support)
- [License](#license)
- [Code of conduct](#code-of-conduct)
- [Contribution guide](#contribution-guide)

## Installation

Run:

```
$ gem install tomo-plugin-nvm
```

Or add it to your Gemfile:

```ruby
gem "tomo-plugin-nvm"
```

Then add the following to `.tomo/config.rb`:

```ruby
plugin "nvm"

set nvm_node_version: "10.16.0" # required
set nvm_yarn_version: "1.16.0"  # optional

setup do
  # Place this task before any steps that require node/yarn
  run "nvm:install"
end
```

## Settings

| Name               | Purpose                                      | Default     |
| ------------------ | -------------------------------------------- | ----------- |
| `bashrc_path`      | Location of the deploy user’s `.bashrc` file | `".bashrc"` |
| `nvm_version`      | Version of nvm to install                    | `"0.34.0"`  |
| `nvm_node_version` | Version of node to install                   | `nil`       |
| `nvm_yarn_version` | Version of yarn to install                   | `nil`       |

## Tasks

### nvm:install

Installs nvm, uses nvm to install node, and makes the desired version of node the global default version for the deploy user. During installation, the user’s bashrc file is modified so that nvm is automatically loaded for interactive and non-interactive shells.

You must supply a value for the `nvm_node_version` setting for this task to work. If the `nvm_yarn_version` setting is specified, yarn is also installed globally via npm. This setting is optional.

`nvm:install` is intended for use as a [setup](https://tomo.mattbrictson.com/commands/setup/) task.

## Support

If you want to report a bug, or have ideas, feedback or questions about the gem, [let me know via GitHub issues](https://github.com/mattbrictson/tomo-plugin-nvm/issues/new) and I will do my best to provide a helpful answer. Happy hacking!

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).

## Code of conduct

Everyone interacting in this project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).

## Contribution guide

Pull requests are welcome!
