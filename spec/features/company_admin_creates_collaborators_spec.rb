require "rails_helper"

RSpec.describe "company admin creates collaborators" do
  context "a company admin" do
    let!(:company) { Fabricate(:company) }
    let!(:admin) { Fabricate(:user, company_id: company.id, roles: %w(company_admin)) }
    let!(:user) { Fabricate(:user, username: "collaborator", roles: %w(registered_user), email: "collaborator@email.com") }

    it "creates a collaborator" do
      login_as(admin, root_path)

      click_link "Account"
      click_link "Collaborators"

      expect(current_path).to eq company_users_path(company: company.url)

      within(".page-header") do
        expect(page).to have_content "#{company.name}"
        expect(page).to have_content "Registered Collaborators"
      end

      click_link "Add Collaborator"

      expect(current_path).to eq new_company_user_path(company: company.url)

      within(".new-user-form") do
        expect(page).to have_content "Find User"
        fill_in "search-field", with: "collaborator"
        click_link "Select"
      end

      within(".collaborators") do
        expect(page).to have_content "collaborator"
        expect(page).to have_content "collaborator@email.com"
      end

      expect(current_path).to eq company_users_path(company: company.url)

      within(".body") do
        within(".collab-info") do
          expect(page).to have_content "#{user.name}"
          expect(page).to have_link "Edit"
          expect(page).to have_link "Delete"
        end
      end
    end
  end
end
