require 'rails_helper'

RSpec.feature "User", type: :feature do
  it "can register successfully" do
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
