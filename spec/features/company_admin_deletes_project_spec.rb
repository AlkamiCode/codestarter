require "rails_helper"

RSpec.describe "Company admin can delete project", type: :feature do
  let!(:company) { Fabricate(:company) }
  let!(:project1) { Fabricate(:project, company_id: company.id) }
  let!(:project2) { Fabricate(:project, name: "Another Project", company_id: company.id) }
  let!(:user) { Fabricate(:user, company_id: company.id, roles: %w(company_admin)) }

  context "can delete a project" do
    it "from the companies/projects page" do
      login_as(user, root_path)
      expect(current_path).to eq root_path

      click_link "Account"
      click_link "#{company.name}'s dashboard"

      click_link "All Projects"

      expect(current_path).to eq company_projects_path(company: company.url)
      expect(page).to have_content project1.name
      expect(page).to have_content project2.name

      first(:link, "Delete").click
      expect(current_path).to eq company_projects_path(company: company.url)
      expect(page).to have_content "#{project1.name} successfully removed."
      expect(page).to have_content project2.name
    end

    it "form the projects page" do
      login_as(user, root_path)
      expect(current_path).to eq root_path

      click_link "Projects"
      first(:link, "View Project").click

      expect(page).to have_content project1.name
      first(:link, "Delete").click

      expect(current_path).to eq company_projects_path(company: company.url)
      expect(page).to have_content "#{project1.name} successfully removed."
      expect(page).to have_content project2.name
    end
  end
end
