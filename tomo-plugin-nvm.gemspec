require_relative "lib/tomo/plugin/nvm/version"

Gem::Specification.new do |spec|
  spec.name = "tomo-plugin-nvm"
  spec.version = Tomo::Plugin::Nvm::VERSION
  spec.authors = ["Matt Brictson"]
  spec.email = ["opensource@mattbrictson.com"]

  spec.summary = "A tomo plugin to manage node and yarn via nvm"
  spec.homepage = "https://github.com/mattbrictson/tomo-plugin-nvm"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/mattbrictson/tomo-plugin-nvm/issues",
    "changelog_uri" => "https://github.com/mattbrictson/tomo-plugin-nvm/releases",
    "source_code_uri" => "https://github.com/mattbrictson/tomo-plugin-nvm",
    "homepage_uri" => spec.homepage
  }

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.glob(%w[LICENSE.txt README.md {exe,lib}/**/*]).reject { |f| File.directory?(f) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "tomo", "~> 1.0"
end
