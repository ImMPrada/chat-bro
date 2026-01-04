require 'chat_engine/config/initializers/overrides'
require 'chat_engine/config/initializers/listeners'

module ChatEngine
  class Engine < ::Rails::Engine
    isolate_namespace ChatEngine
    config.generators.api_only = true

    initializer 'chat_engine.overrides' do
      ChatEngine::Config::OverridesInitializer.load!(config)
    end

    initializer 'chat_engine.listeners' do
      ChatEngine::Config::ListenersInitializer.load!(config)
    end
  end
end
