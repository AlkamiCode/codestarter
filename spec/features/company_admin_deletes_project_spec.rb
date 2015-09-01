require "rails_helper"

RSpec.describe "Company admin can delete project", type: :feature do
  let!(:company) { Fabricate(:company) }
  let!(:project1) { Fabricate(:project, company_id: company.id) }
  let!(:project2) { Fabricate(:project, name: "Another Project", company_id: company.id) }
  let!(:user) { Fabricate(:user, company_id: company.id, roles: %w(company_admin)) }

  context "as a company admin" do
    it "can delete a project" do
      login_as(user, root_path)
      expect(current_path).to eq root_path

      click_on "Account"
      click_on "#{company.name}'s dashboard"
      click_on "All Projects"

      expect(current_path).to eq company_projects_path(company: company.url)
      expect(page).to have_content "Sample Project"
      expect(page).to have_content "Another Project"

      first(:link, "Delete").click
      expect(current_path).to eq company_projects_path(company: company.url)
      expect(page).not_to have_content "Sample Project"
      expect(page).to have_content "Another Project"
    end
  end
end
