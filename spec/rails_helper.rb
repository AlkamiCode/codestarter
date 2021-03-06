ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require "spec_helper"
require "rspec/rails"

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  def login_as(user, path)
    visit path
    click_button "Log In"

    within (".login-modal") do
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Log In"
    end
  end

  def cart
    @cart ||= Cart.new(session[:cart])
  end
end
