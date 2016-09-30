require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GameServer
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('services')

    config.generators do |g|
      g.stylesheets = false
      g.javascripts = false
      g.helper = false
      g.test_framework nil
    end
  end
end
