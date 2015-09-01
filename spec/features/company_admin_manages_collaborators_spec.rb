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
      click_link "Collaborators"

      expect(current_path).to eq company_users_path(company: company.url)

      within(".collaborators tr#user_#{user.id}") do
        expect(page).to have_content user.username
        expect(page).to have_content user.email
        click_on "Remove"
      end

      expect(current_path).to eq company_users_path(company: company.url)
      expect(user.collaborator?).to eq (false)
      expect(user.former_collaborator?).to eq (true)

      within(".collaborators td#reinstate") do
        expect(page).to_not have_link "Remove"
        expect(page).to have_link "Reinstate"
      end
    end
  end
end
