require "rails_helper"

RSpec.describe "user does not have link to empty cart", type: :feature do
  let!(:user) { Fabricate(:user, roles: %w(registered_user)) }
  let!(:company) { Fabricate(:company) }
  let!(:project) { Fabricate(:project, company_id: company.id) }

  scenario "can only visit cart page when cart has a cart_item" do
    visit root_path

    page.find("#cart").click

    expect(current_path).to eq(root_path)

    click_link "Projects"

    expect(current_path).to eq projects_path
    first(:link, "Fund This Project").click

    page.find("#cart").click

    expect(current_path).to eq cart_path
  end

  scenario "user gets redirected home when she empties cart" do
    visit projects_path

    first(:link, "Fund This Project").click

    page.find("#cart").click

    expect(current_path).to eq cart_path
    expect(page).to have_content(project.name)

    click_link("Remove")

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Your Cart Is Empty!")
  end
end
