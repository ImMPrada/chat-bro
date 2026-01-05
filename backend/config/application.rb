require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile
Bundler.require(*Rails.groups)

module ChatBro
  class Application < Rails::Application
    config.load_defaults 7.2

    # API-only mode
    config.api_only = true

    # Background jobs
    config.active_job.queue_adapter = :delayed_job

    # Autoload lib/
    config.autoload_lib(ignore: %w[assets tasks])
  end
end
