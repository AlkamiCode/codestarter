require "rails_helper"

RSpec.feature User, type: :feature do
  scenario "visits landing page and sees links" do
    visit root_path

    within(".navbar") do
      expect(page).to have_link("Sign Up")
      expect(page).to have_link("Login")
      expect(page).to have_link("Cart")
      expect(page).to have_link("Contact")
    end
    expect(page).to have_link("Featured Projects")
  end
end
