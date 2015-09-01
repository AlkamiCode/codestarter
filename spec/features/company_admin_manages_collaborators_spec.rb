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
    it "removes a collaborator" do
      login_as(admin, root_path)

      click_link "Account"
      click_link "#{company.name}'s dashboard"

      expect(current_path).to eq company_dashboard_path(company: company.url)

      click_link "Collaborators"

      within(".collaborators tr#user_#{user.id}") do
        expect(page).to have_content user.username
        expect(page).to have_content user.email
        click_on "Remove"
      end

      expect(current_path).to eq company_users_path(company: company.url)

      within(".collaborators") do
        expect(page).to_not have_content user.username
        expect(page).to_not have_content user.email
      end
    end
  end
end
