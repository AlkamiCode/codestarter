require "rails_helper"

RSpec.describe "registered user fully funds project", type: :feature do
  let!(:user) { Fabricate(:user, roles: %w(registered_user)) }
  let!(:company) { Fabricate(:company) }
  let!(:project) { Fabricate(:project, company_id: company.id) }

  scenario "project transitions from active to funded" do
    login_as(user, root_path)

    click_link "Projects"
    expect(current_path).to eq projects_path

    first(:link, "Fund This Project").click
    page.find("a[href='/cart']").click

    within(".cart-options") do
      fill_in 'funding_amount', with: "300"
      click_button "Set Amount"
    end

    expect(page).to have_content "$300.00"
    expect(project.status).to eq("active")

    click_link "Checkout"
    project.reload

    expect(current_path).to eq orders_path
    expect(project.status).to eq("funded")

    visit projects_path
    expect(page).to_not have_content(project.name)
  end
end
