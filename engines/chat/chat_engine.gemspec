require_relative 'lib/chat_engine/version'

Gem::Specification.new do |spec|
  spec.name        = 'chat_engine'
  spec.version     = ChatEngine::VERSION
  spec.authors     = ['Miguel Prada']
  spec.email       = ['mprada@bro-garden.dev']
  spec.homepage    = 'https://github.com/bro-garden/chat'
  spec.summary     = 'Real-time messaging and chat functionality for bro-garden applications'
  spec.description = 'Rails engine providing chat rooms, messages, and real-time communication capabilities'
  spec.license     = 'MIT'

  spec.metadata['allowed_push_host'] = 'https://rubygems.pkg.github.com'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/bro-garden/chat'
  spec.metadata['changelog_uri'] = 'https://github.com/bro-garden/chat/blob/main/UPGRADING.md'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md', 'spec/factories/**/*']
  end

  spec.required_ruby_version = '>= 3.2.2'

  spec.add_dependency 'jbuilder', '~> 2.12'
  spec.add_dependency 'rails', '~> 7.2'
  spec.add_dependency 'uuid7', '~> 0.2.0'
  spec.add_dependency 'wisper', '~> 3.0'

  spec.add_development_dependency 'brakeman'
  spec.add_development_dependency 'bump', '~> 0.10.0'
  spec.add_development_dependency 'bundle-audit', '~> 0.1.0'
  spec.add_development_dependency 'debug'
  spec.add_development_dependency 'factory_bot_rails'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'mdl', '~> 0.13.0'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rails'
  spec.add_development_dependency 'shoulda-matchers'
  spec.add_development_dependency 'wisper-rspec'
end
