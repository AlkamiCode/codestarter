require "rails_helper"

RSpec.feature User, type: :feature do
  scenario "visits landing page and sees links" do
    visit root_path

    expect(page).to have_link("Sign Up")
    expect(page).to have_link("Login")
    expect(page).to have_link("About")
    expect(page).to have_link("Contact")
    expect(page).to have_link("Featured Projects")
  end
end
