# frozen_string_literal: true

require_relative "lib/rails_ai_tag/version"

Gem::Specification.new do |spec|
  spec.name = "rails_ai_tag"
  spec.version = RailsAiTag::VERSION
  spec.authors = ["Jordi Bari Corberó"]
  spec.email = ["jordi.bari@gmail.com"]

  spec.summary     = "Custom Rails helper for AI-generated image tags"
  spec.description = "A gem that extends Rails helpers with AI-powered image generation. Current functionality includes a custom image_tag helper that generates images based on a description."
  spec.homepage = "https://rails-cat.github.io/"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://rails-cat.github.io/"
  spec.metadata["changelog_uri"] = "https://rails-cat.github.io/"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
