require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ha2
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.generators do |generate|
      generate.helper false
      generate.assets false
      generate.test_framework :rspec
      generate.model_specs false
      generate.request_specs false
      generate.routing_specs false
      generate.controller_specs false
      generate.view_specs false
      generate.fixtures false
      generate.factory_girl false
      generate.orm :active_record, primary_key_type: :uuid
    end
  end
end
