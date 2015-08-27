require "rails_helper"

RSpec.describe "registered user", type: :feature do
  scenario "updates personal info" do
    visit root_path

    expect do
      within (".register-modal") do
        fill_in "Username", with: "Lovisa"
        fill_in "Password", with: "rocks"
        fill_in "Password confirmation", with: "rocks"
        click_button "Create Account"
      end
    end.to change { User.count }.from(0).to(1)

    
  end
end

# As a registered user,
# and I click the link "Account" in the navbar,
# I am redirected to my account page,
# and I can edit my account details,
# and when I click the button
# "update", my new details are saved.
