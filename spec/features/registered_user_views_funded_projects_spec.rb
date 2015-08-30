require "rails_helper"

RSpec.describe "registered user can view funded projects", type: :feature do
  let!(:company) { Fabricate(:company) }
  let!(:project) { Fabricate(:project) }
  let!(:project_2) { Fabricate(:project) }
  let!(:project_3) { Fabricate(:project) }
  let!(:user) { Fabricate(:user, roles: %w(registered_user)) }

  scenario "views her funded projects" do
    login_as(user, root_path)

    click_link "Projects"
    expect(current_path).to eq projects_path

    first(:link, "Fund This Project").click
    page.find("a[href='/cart']").click

    within(".cart-options") do
      fill_in 'funding_amount', with: "50"
      click_button "Set Amount"
    end

    expect(page).to have_content "$50.00"
    click_link "Checkout"

    expect(current_path).to eq orders_path
  end
end
