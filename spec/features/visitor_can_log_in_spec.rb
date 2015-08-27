require "rails_helper"

RSpec.feature "Registered user can log in", type: :feature do
  context "as an already registered user" do
    let!(:user) { User.create!(username: "marla", password: "password", password_confirmation: "password") }

    it "can log in via the navbar" do
      visit root_path
      click_link "Log In"

      within (".login-modal") do
        fill_in "Username", with: "marla"
        fill_in "Password", with: "password"
        click_button "Log In"
      end
    end
  end
end
