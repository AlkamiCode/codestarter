require "rails_helper"

RSpec.describe "company admin manages collaborators", type: :feature do
  let!(:company) { Fabricate(:company) }
  let!(:admin) { Fabricate(:user,
                           company_id: company.id,
                           roles: %w(company_admin)) }
  let!(:user) { Fabricate(:user,
                          username: "collaborator",
                          company_id: company.id,
                          roles: %w(collaborator@gmail.com),
                          email: "collaborator@email.com") }

  context "a company admin" do
    it "changes a collaborators role to former_collaborator" do
      login_as(admin, root_path)

      click_link "Account"
      click_link "#{company.name}'s dashboard"

      expect(current_path).to eq company_dashboard_path(company: company.url)

      click_link "Collaborators"

      within(".table-responsive .user:last-of-type") do
        expect(page).to have_content user.username
        expect(page).to have_content user.email
        expect(page).to_not have_link "Reinstate"
        click_link "Remove"
      end

      expect(current_path).to eq company_users_path(company: company.url)
      expect(user.collaborator?).to eq (false)
      expect(user.former_collaborator?).to eq (true)

      within(".table-responsive .user:last-of-type") do
        expect(page).to have_content user.username
        expect(page).to have_content user.email
        expect(page).to_not have_link "Remove"
        click_link "Reinstate"
      end

      expect(user.collaborator?).to eq(true)
      expect(user.former_collaborator?).to eq(false)
    end

    it "does not appear in list of collaborators" do
      login_as(admin, root_path)

      click_link "Account"
      click_link "#{company.name}'s dashboard"

      expect(current_path).to eq company_dashboard_path(company: company.url)

      click_link "Collaborators"

      within(".table-responsive .user:last-of-type") do
        expect(page).to have_content user.username
        expect(page).to have_content user.email

        expect(page).to_not have_content admin.username
        expect(page).to_not have_content admin.email

        expect(page).to_not have_link "Reinstate"
        click_link "Remove"
      end
    end
  end
end
