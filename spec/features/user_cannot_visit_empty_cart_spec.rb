require "rails_helper"

RSpec.describe "user does not have link to empty cart", type: :feature do
  let!(:user) { Fabricate(:user, roles: %w(registered_user)) }
  let!(:company) { Fabricate(:company) }
  let!(:project) { Fabricate(:project, company_id: company.id) }

  scenario "can only visit cart page when cart has a cart_item" do
    visit root_path

    page.find("#cart").click

    expect(current_path).to eq(root_path)

    # login_as(user, root_path)

    click_link "Projects"

    expect(current_path).to eq projects_path
    first(:link, "Fund This Project").click

    page.find("#cart").click

    expect(current_path).to eq cart_path
  end
end
