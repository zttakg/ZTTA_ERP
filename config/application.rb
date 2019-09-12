require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TemirtulparErp
  class Application < Rails::Application
    config.load_defaults 5.2
    config.i18n.default_locale = :ru
    config.autoload_paths << Rails.root.join('lib')
    config.eager_load_paths << Rails.root.join('lib')
    config.active_job.queue_adapter = :sidekiq
  end
end
