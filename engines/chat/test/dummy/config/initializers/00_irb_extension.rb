module IRBExtension
  def start
    load_factories if Rails.env.test? || Rails.env.development?
    super
  end

  def load_factories
    FactoryBot.definition_file_paths = Rails.root.glob('../../spec/factories/')

    Rails.application.config.engines.each do |engine_name|
      require "#{engine_name.underscore}/test_helpers/factories"

      puts "Loading factories for #{engine_name}"
      "#{engine_name}::TestHelpers::Factories".constantize.include_factories
    end

    FactoryBot.factories.clear
    FactoryBot.find_definitions

    TOPLEVEL_BINDING.eval('self').extend(FactoryBot::Syntax::Methods)
  end
end
