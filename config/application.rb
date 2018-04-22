require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Photohosting
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller
    config.i18n.default_locale = :ru
    config.i18n.locale = :ru
    config.time_zone = 'Moscow' # Your local time zone
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = false
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
