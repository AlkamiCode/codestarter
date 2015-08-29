require "rails_helper"

RSpec.feature "Registered user can log in", type: :feature do
  context "as an already registered user" do
    let!(:user) { Fabricate(:user, roles: %w(registered_user)) }

    it "can log in via the navbar" do
      visit root_path
      click_link "Log In"

      within (".login-modal") do
        fill_in "Username", with: "marla"
        fill_in "Password", with: "password"
        click_button "Log In"
      end

      expect(current_path).to eq root_path
      expect(page).to have_content "Logout"

      within(".nav") do
        expect(page).not_to have_content "Log In"
        expect(page).not_to have_content "Sign Up"
      end
    end

    it "can't log in with invalid params" do
      visit root_path
      click_link "Log In"

      within (".login-modal") do
        fill_in "Username", with: "marla"
        fill_in "Password", with: "wrongpass"
        click_button "Log In"
      end

      expect(page).to have_content "Invalid username or password"
    end
  end
end
