require "rails_helper"

RSpec.describe "company admin can edit projects", type: :feature do
  let!(:company) { Fabricate(:company) }
  let!(:project) { Fabricate(:project, company_id: company.id) }

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
end
