require File.expand_path("../boot", __FILE__)

require "rails"

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module JurassicParka
  class Application < Rails::Application
    # config.action_mailer.delivery_method = :smtp

    # config.action_mailer.smtp_settings = {
    #   address:                "smtp.mandrillapp.com",
    #   port:                   587,
    #   domain:                 ENV['mandrill_domain'],
    #   user_name:              "lovisasvallingson@gmail.com",
    #   password:               ENV['mandrill_api_key'],
    #   authentication:         'plain',
    #   enable_starttls_auto:   true,
    # }

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
        :address              => 'smtp.gmail.com',
        :port                 => 587,
        :domain               => 'gmail.com',
        :user_name            => ENV['gmail_username'],
        :password             => ENV['gmail_password'],
        :authentication       => 'login',
        :enable_starttls_auto => true
    }

    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths << config.root.join("app/services")
  end
end
