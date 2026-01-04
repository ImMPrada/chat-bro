module ChatEngine
  module TestHelpers
    module Factories
      def self.include_factories
        factory_path = File.expand_path('../../../spec/factories', __dir__)
        FactoryBot.definition_file_paths << factory_path
      end
    end
  end
end
