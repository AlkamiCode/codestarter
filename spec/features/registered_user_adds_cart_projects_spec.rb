require 'rails_helper'

RSpec.feature "Registered user", type: :feature do
  let!(:project) { Fabricate(:project) }
  let!(:project_2) { Fabricate(:project, name: "Second Project") }

  it "can register successfully" do
    visit root_path

    expect do
      within (".modal-content") do
        fill_in "Username", with: "Lovisa"
        fill_in "Password", with: "rocks"
        fill_in "Password confirmation", with: "rocks"
        click_button "Create Account"
      end
    end.to change { User.count }.from(0).to(1)
  end

  it "can add projects to cart" do
  end
end
