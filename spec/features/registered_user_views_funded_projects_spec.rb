require "rails_helper"

RSpec.describe "registered user", type: :feature do
  let!(:company) { Fabricate(:company) }
  let!(:project) { Fabricate(:project) }
  let!(:project_2) { Fabricate(:project) }
  let!(:user) { Fabricate(:user) }

  scenario "views her funded projects" do
    login_as(user, root_path)

    click_link "Projects"
    expect(current_path).to eq projects_path

    first(:link, "Fund This Project").click
    page.find("a[href='/cart']").click

    within(".cart-options") do
      select 1500, from: "funding_amount"
      click_button "Set Amount"
    end

    expect(page).to have_content "$1,500.00"
    click_link "Checkout"

    expect(current_path).to eq orders_path
  end
end
