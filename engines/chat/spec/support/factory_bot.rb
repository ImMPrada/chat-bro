require 'factory_bot_rails'

FactoryBot.definition_file_paths = Rails.root.glob('../../spec/factories/')

# TODO: Uncomment when engine dependencies are available
# UsersEngine::TestHelpers::Factories.include_factories

FactoryBot.factories.clear
FactoryBot.find_definitions

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
