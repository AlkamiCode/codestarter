require "rails_helper"

RSpec.describe "company admin views past collaborators" do
  context "a company admin" do
    let!(:company) { Fabricate(:company) }
    let!(:admin) { Fabricate(:user,
                             company_id: company.id,
                             roles: %w(company_admin)) }
    let!(:user) { Fabricate(:user,
                            username: "collaborator",
                            roles: %w(registered_user),
                            email: "collaborator@email.com") }

    it "views ALL past and current collaborators of the company" do
      login_as(admin, root_path)

      click_link "Account"
      click_link "Collaborators"

      expect(current_path).to eq company_users_path(company: company.url)

      click_link "Add Collaborator"

      expect(current_path).to eq new_company_user_path(company: company.url)

      within(".new-user-form") do
        fill_in "searchfield", with: "collaborator"
        click_button "Search"
      end

      within(".search-result") do
        expect(page).to have_content user.username
        expect(page).to have_content user.email
        click_button "Select"
      end

      within(".collaborators") do
        expect(page).to have_content "collaborator"
        expect(page).to have_content "collaborator@email.com"
      end

      within("#sidebar") do
        click_link "Collaborators"
      end

      expect(current_path).to eq company_users_path(company: company.url)

      within(".collaborators") do
        expect(page).to have_content user.username
        expect(page).to have_content user.email
        expect(page).to have_link "Remove"
        expect(page).to have_link "Reinstate"
      end

      within(".collaborators") do
        
      end

    end
  end
end
