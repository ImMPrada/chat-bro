# Create Rails Engine

Create a new Rails engine following bro-garden conventions and best practices.

## Instructions

You will help the user create a new Rails engine in the `engines/` directory following these steps:

### 1. Gather Information

Ask the user for:
- **Engine name** (in snake_case, e.g., `notifications_engine`)
- **Brief description** of what the engine does
- **GitHub repository name** (in kebab-case, e.g., `notifications-engine`)
- **Engine repository folder** (in kebab-case, e.g., `notifications-engine`)
- **Author name** (default: "Miguel Prada")
- **Author email** (default: "mprada@bro-garden.dev")

### 2. Create the Engine Structure

Navigate to the `engines/` directory and create the engine:

```bash
cd engines
rails plugin new ENGINE_NAME --mountable --api --skip-ci
```

If the folder already exists (in snake_case), run inside it:
```bash
cd ENGINE_NAME
rails plugin new . --mountable --api --skip-ci
```

Then rename the directory to kebab-case for GitHub convention if needed, remove it '-engine' at the end.

### 3. Copy Configuration Files

Copy these files from the `engines/kanban` directory:

- `.gitignore` - Git ignore patterns
- `.mdlrc` - Markdown linter configuration
- `.rspec` - RSpec configuration
- `.rubocop.yml` - RuboCop style guide configuration
- `.ruby-version` - Ruby version specification (3.3.0)

### 4. Create UPGRADING.md

Create an `UPGRADING.md` file with this initial content:

```markdown
# Upgrading Guide

## From `0.1.0` to `Unreleased`

## From `0.0.1` to `0.1.0`

Initial release.
```

### 5. Update Gemspec

Update the `.gemspec` file based on `engines/kanban/kanban_engine.gemspec`:

- Set proper name, version, authors, email, homepage
- Set summary and description
- Add metadata including allowed_push_host (https://rubygems.pkg.github.com)
- Set required_ruby_version to >= 3.2.2
- Add these dependencies:
  ```ruby
  spec.add_dependency 'jbuilder', '~> 2.12'
  spec.add_dependency 'rails', '>= 7.2.2'
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
  spec.add_development_dependency 'shoulda-matchers'
  spec.add_development_dependency 'wisper-rspec'
  ```
- Update spec.files to include factories:
  ```ruby
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md', 'spec/factories/**/*']
  end
  ```

### 6. Update Gemfile

Update the `Gemfile` based on `engines/kanban/Gemfile`:

```ruby
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

gem 'puma'
gem 'sqlite3'
gem 'sprockets-rails'

# Add any engine dependencies here (users_engine, personas_engine, etc.)
gem 'users_engine', path: '../users'

# Shared dependencies
gem 'bg_cop', path: '../../shared/bg-cop'
gem 'stakes', path: '../../shared/stakes'

group :test, :development do
  gem 'byebug', '~> 11.1'
  gem 'timecop', '~> 0.9.10'
end
```

### 7. Clean Up Default Test Files

Remove minitest test files but keep the dummy app:
```bash
rm -rf test/ENGINE_NAME_test.rb
rm -rf test/integration
```

### 8. Set Up RSpec Testing

Create the spec directory structure and files:

**spec/rails_helper.rb** - Copy from `engines/kanban/spec/rails_helper.rb`
**spec/spec_helper.rb** - Copy from `engines/kanban/spec/spec_helper.rb`
**spec/swagger_helper.rb** - Copy from `engines/kanban/spec/swagger_helper.rb`

Create `spec/support/` directory with:

**spec/support/factory_bot.rb**:
```ruby
require 'factory_bot_rails'

FactoryBot.definition_file_paths = Rails.root.glob('../../spec/factories/')
UsersEngine::TestHelpers::Factories.include_factories
# Add other engine factories as needed

FactoryBot.factories.clear
FactoryBot.find_definitions

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
```

**spec/support/shoulda_matchers.rb** - Copy from `engines/kanban/spec/support/shoulda_matchers.rb`

### 9. Configure Factory Sharing

Create `lib/ENGINE_NAME/test_helpers/factories.rb`:

```ruby
module EngineName
  module TestHelpers
    module Factories
      def self.include_factories
        factory_path = File.expand_path('../../../spec/factories', __dir__)
        FactoryBot.definition_file_paths << factory_path
      end
    end
  end
end
```

Update `lib/ENGINE_NAME.rb` to require this file:
```ruby
Dir[File.join(__dir__, 'ENGINE_NAME/test_helpers/**/*.rb')].each { |file| require file }
```

### 10. Set Up Console Helpers

Create `test/dummy/config/initializers/00_irb_extension.rb` - Copy from `engines/kanban/test/dummy/config/initializers/00_irb_extension.rb`

Create `test/dummy/config/initializers/console.rb` - Copy from `engines/kanban/test/dummy/config/initializers/console.rb`

### 11. Configure Engine Initializers

Create the initializer structure in `lib/ENGINE_NAME/config/initializers/`:

**overrides.rb**:
```ruby
module EngineName
  module Config
    class OverridesInitializer
      def self.load!(config)
        overrides = File.expand_path('../../../../app/overrides', __dir__)
        Rails.autoloaders.main.ignore(overrides)

        config.to_prepare do
          Dir.glob("#{overrides}/**/*_override.rb").sort.each do |override|
            load override
          end
        end
      end
    end
  end
end
```

**listeners.rb**:
```ruby
require 'wisper'

module EngineName
  module Config
    class ListenersInitializer
      def self.load!(config)
        config.to_prepare do
          # Add Wisper listeners here as they're created
          # Example:
          # Wisper.subscribe(EngineName::SomeListener.new)
        end
      end
    end
  end
end
```

Update `lib/ENGINE_NAME/engine.rb` to use these initializers:
```ruby
require 'ENGINE_NAME/config/initializers/overrides'
require 'ENGINE_NAME/config/initializers/listeners'

module EngineName
  class Engine < ::Rails::Engine
    isolate_namespace EngineName
    config.generators.api_only = true

    initializer 'ENGINE_NAME.overrides' do
      EngineName::Config::OverridesInitializer.load!(config)
    end

    initializer 'ENGINE_NAME.listeners' do
      EngineName::Config::ListenersInitializer.load!(config)
    end
  end
end
```

### 12. Update Main Engine Module

Update `lib/ENGINE_NAME.rb`:

```ruby
require 'ENGINE_NAME/version'
require 'ENGINE_NAME/engine'

require 'jbuilder'
require 'stakes'

module EngineName
  # Add configuration options here as needed
  # Example:
  # mattr_accessor :some_config_option
  # @@some_config_option = true

  mattr_accessor :logger
  @@logger = Stakes::Logs::Adapter.new([:rails])
end
```

### 13. Create README.md

Generate a README based on `engines/kanban/README.md` with:
- Engine description
- Usage instructions (Gemfile setup, mounting, migrations)
- Configuration options
- Local setup instructions
- Contributing guidelines
- License information

### 14. Create CLAUDE.md

Create a `CLAUDE.md` file documenting:
- Development commands (testing, code quality, database operations)
- Architecture overview (models, dependencies, API structure)
- Testing conventions
- Engine integration instructions
- Any specific domain logic or patterns

### 15. Create Directory Structure

Create these empty directories if they don't exist:
- `app/overrides/` - For extending other engines' models
- `app/listeners/` - For Wisper event listeners
- `app/controllers/ENGINE_NAME/v1/` - For API controllers
- `app/models/ENGINE_NAME/` - For models
- `app/services/ENGINE_NAME/` - For service objects
- `app/views/ENGINE_NAME/v1/` - For Jbuilder views
- `spec/factories/` - For FactoryBot factories
- `spec/models/` - For model specs
- `spec/requests/` - For API request specs
- `spec/services/` - For service specs

### 16. Install Dependencies

```bash
cd engines/ENGINE_NAME
bundle install
```

### 17. Set Up Database

```bash
bin/rails db:create
bin/rails db:schema:load
```

### 18. Verify Setup

Run these commands to verify everything is working:

```bash
bundle exec rspec  # Should pass (no tests yet)
bundle exec rubocop  # Should pass
bundle exec brakeman  # Should pass
bundle exec bundle-audit  # Should pass
```

### 19. Initial Git Commit

If not already done, create initial commit:
```bash
git add .
git commit -m "Initial engine setup for ENGINE_NAME"
```

### 20. Create GitHub Workflow

Use the SlashCommand tool to execute the `/add-ci` command to configure the new engine's CI/CD system. This will set up the GitHub Actions workflow for continuous integration.


## Important Notes

- Follow naming conventions: snake_case for module names, kebab-case for repo names
- All user-facing text should be in Colombian Spanish
- Use UUID-based routing for external API stability
- Never expose internal IDs in APIs
- The engine should be isolated and communicate with other engines via Wisper events
- Always update UPGRADING.md when making breaking changes
- Ruby style: Do not include `# frozen_string_literal: true` at the top of files

## After Creation

The user should:
1. Implement the core domain logic
2. Add tests for all functionality
4. Update UPGRADING.md with any dependencies
5. Publish the gem to GitHub Packages using the /bump command
