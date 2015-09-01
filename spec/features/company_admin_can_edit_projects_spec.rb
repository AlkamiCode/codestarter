require "rails_helper"

RSpec.describe "company admin can edit projects", type: :feature do
  let!(:company) { Fabricate(:company) }
  let!(:category) { Fabricate(:category) }
  let!(:project) { Fabricate(:project, company_id: company.id, category_id: category.id) }

  context "as a company admin" do
    let!(:user) { Fabricate(:user, company_id: company.id, roles: %w(company_admin)) }

    it "can edit a project for its company" do
      login_as(user, root_path)

      click_link "Account"
      click_link "Sample Company's Projects"
      click_on "Edit"

      fill_in "Name", with: "New name"
      fill_in "Description", with: "New description"
      click_on "Update"

      expect(current_path).to eq company_project_path(company: company.url, id: project.id)
      expect(page).to have_content "New name"
      expect(page).to have_content "New description"
      expect(page).not_to have_content "Sample Project"
      expect(page).not_to have_content "To make the sample world a better place."
    end
  end

  context "as another company admin" do
    let!(:company2) { Fabricate(:company, name: "company2") }
    let!(:project2) { Fabricate(:project, name: "project2", company_id: company2.id) }
    let!(:user2) { Fabricate(:user, username: "user2", company_id: company2.id, roles: %w(company_admin)) }

    it "can't edit projects for another company" do
      login_as(user2, root_path)
      visit "/#{company.url}/projects/#{company.projects.first.id}/edit"
      expect(current_path).to eq root_path
      expect(page).to have_content "You are not authorized to view this page."
    end
  end
end
