require 'rails_helper'

RSpec.feature "User can log out", type: :feature do
  scenario "can register successfully from home page" do
    visit root_path
    click_link "Sign Up"

    expect do
      within (".register-modal") do
        fill_in "Username", with: "Lovisa"
        fill_in "Password", with: "rocks"
        fill_in "Password confirmation", with: "rocks"
        fill_in "Email", with: "lovisa@email.com"
        click_button "Create Account"
      end
    end.to change { User.count }.from(0).to(1)

    expect(current_path).to eq root_path
  end

  scenario "can register successfully from cart page" do
    visit cart_path

    expect do
      within (".register-modal") do
        fill_in "Username", with: "Dmitry"
        fill_in "Password", with: "rocks"
        fill_in "Password confirmation", with: "rocks"
        fill_in "Email", with: "dmitry@email.com"
        click_button "Create Account"
      end
    end.to change { User.count }.from(0).to(1)

    expect(current_path).to eq cart_path
  end

  scenario "after user registers user is able to logout" do
    visit projects_path

    expect do
      within (".register-modal") do
        fill_in "Username", with: "Marla"
        fill_in "Password", with: "rocks"
        fill_in "Password confirmation", with: "rocks"
        fill_in "Email", with: "marla@email.com"
        click_button "Create Account"
      end
    end.to change { User.count }.from(0).to(1)

    expect(current_path).to eq(projects_path)
    expect(page).to have_link "Logout"
    expect(page).to_not have_link "Login"
    expect(page).to_not have_link "Register"

    click_link "Logout"
    expect(@current_user).to eq(nil)
    expect(page).to_not have_link "Logout"
    expect(page).to have_link "Log In"
    expect(page).to have_link "Sign Up"
    expect(page).to have_content "You have succesfully logged out."
  end
end
