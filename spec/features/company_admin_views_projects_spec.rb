require "rails_helper"

RSpec.describe "company admin views projects" do
  let!(:company) { Fabricate(:company) }
  let!(:project) { Fabricate(:project, company_id: company.id) }
  let!(:user) { Fabricate(:user, company_id: company.id, roles: %w(company_admin)) }

  context "a company admin" do
    it "views all projects" do
      login_as(user, root_path)
      expect(current_path).to eq root_path

      click_link "Account"
      click_link "#{company.name}'s Projects"

      expect(current_path).to eq company_projects_path(company: company.url)

      within(".row") do
        within(".portfolio-item") do
          expect(page).to have_content project.name
          expect(page).to have_content project.description
          expect(page).to have_content project.funding_in_percentage
          expect(page).to have_link "View Project"
          expect(page).to have_link "Edit"
          expect(page).to have_link "Delete"
        end
      end
    end
  end
end
