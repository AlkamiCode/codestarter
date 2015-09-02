require "rails_helper"

RSpec.describe "collaborator views admin pages", type: :feature do
  let!(:company) { Fabricate(:company) }
  let!(:admin) { Fabricate(:user,
                            company_id: company.id,
                            roles: %w(company_admin)) }
  let!(:collaborator) { Fabricate(:user,
                                   username: "collaborator",
                                   company_id: company.id,
                                   roles: %w(collaborator),
                                   email: "collaborator@email.com") }

  context "a company collaborator" do
    it "views the admin pages" do
      login_as(collaborator, root_path)

      click_link "Account"
      click_link "#{company.name}'s dashboard"

      expect(current_path).to eq company_dashboard_path(company: company.url)

      click_link "Collaborators"

      expect(page).to_not have_link "Add Collaborator"

      within(".collaborators") do
        expect(page).to have_content collaborator.username
        expect(page).to have_content collaborator.email
        expect(page).to_not have_link "Remove"
      end

      within(".admins") do
        expect(page).to have_content admin.username
        expect(page).to have_content admin.email
      end
    end
  end
end
