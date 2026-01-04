module ChatEngine
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
