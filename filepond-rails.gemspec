# frozen_string_literal: true

require_relative 'lib/filepond/rails/version'

Gem::Specification.new do |spec|
  spec.name        = 'filepond-rails'
  spec.version     = Filepond::Rails::VERSION
  spec.authors     = ['Simon Chiu']
  spec.email       = ['simon@furvur.com']
  spec.homepage    = 'https://codewithrails.com/filepond-rails'
  spec.summary     = 'FilePond integration for Rails'
  spec.description = 'Add FilePond server endpoints and form helpers for Rails'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Code-With-Rails/filepond-rails'
  spec.metadata['changelog_uri'] = 'https://github.com/Code-With-Rails/filepond-rails/blob/main/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_dependency 'rails', '>= 7.0', '< 8'
  spec.add_development_dependency 'rubocop', '~> 1.1', '>= 1.1.4'
end
