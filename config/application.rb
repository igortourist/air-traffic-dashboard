require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'resque'
require 'net/http'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dashboard
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths << Rails.root.join('lib')

    # Set up defaults for config.dashboard
    config.before_configuration do
      urls = ::YAML.load_file(Rails.root.join("config/services.yml"))

      config.dashboard =
      ::ActiveSupport::OrderedOptions.new.tap do |dashboard|
        urls.each do |key,value|
          dashboard[key.to_sym] = ENV.fetch(
            "SERVICES_#{key.to_s.upcase}", value)
        end
      end
    end
  end
end
