require 'rails_helper'

RSpec.feature "Registered user", type: :feature do
  let!(:project) { Fabricate(:project) }
  let!(:project_2) { Fabricate(:project, name: "Second Project") }

  it "can register successfully" do
    visit root_path

    within ("#register-modal") do
      fill_in "Username", with: "Lovisa"
      fill_in "Password", with: "rocks"
      click_button "Create Account"
    end
  end

  it "can add projects to cart" do
    
  end
end
