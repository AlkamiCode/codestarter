require "rails_helper"

RSpec.describe "registered user", type: :feature do
  scenario "updates personal info" do
    visit root_path

    expect do
      within (".register-modal") do
        fill_in "Username", with: "Marla"
        fill_in "Password", with: "rocks"
        fill_in "Password confirmation", with: "rocks"
        click_button "Create Account"
      end
    end.to change { User.count }.from(0).to(1)

    expect(User.last.username).to eq("Marla")

    within (".update-modal") do
      fill_in "Username", with: "Marlazz"
      fill_in "Password", with: "rockies"
      fill_in "Password confirmation", with: "rockies"
      click_button "Update Info"
    end
    expect(User.last.username).to eq("Marlazz")
  end
end
