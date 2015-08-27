require "rails_helper"

RSpec.feature User, type: :feature do
  scenario "visits landing page and sees links" do
    visit root_path

    within(".navbar") do
      expect(page).to have_link("Sign Up")
      expect(page).to have_link("Log In")
      expect(page).to have_css(".fa-shopping-cart")
      expect(page).to have_link("Contact")
      expect(page).to have_link("About")
    end
    expect(page).to have_link("Featured Projects")
  end
end
