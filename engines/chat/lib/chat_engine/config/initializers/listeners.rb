require 'wisper'

module ChatEngine
  module Config
    class ListenersInitializer
      def self.load!(config)
        config.to_prepare do
          # Add Wisper listeners here as they're created
          # Example:
          # Wisper.subscribe(ChatEngine::SomeListener.new)
        end
      end
    end
  end
end
