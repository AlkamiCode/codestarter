  require "rails_helper"

RSpec.describe "company admin registers collaborators" do
  context "a company admin" do
    let!(:company) { Fabricate(:company) }
    let!(:admin) { Fabricate(:user,
                             company_id: company.id,
                             roles: %w(company_admin)) }
    let!(:user) { Fabricate(:user,
                            username: "collaborator",
                            roles: %w(registered_user),
                            email: "collaborator@email.com") }

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
      end
    end

    it "can not register a collaborator twice" do
      login_as(admin, root_path)

      click_link "Account"
      click_link "Collaborators"
      click_link "Add Collaborator"

      within(".new-user-form") do
        expect(page).to have_content "Find User"
        fill_in "searchfield", with: "collaborator"
        click_button "Search"
      end
      click_button "Select"

      within(".collaborators") do
        expect(page).to have_content "collaborator"
        expect(page).to have_content "collaborator@email.com"
      end

      click_button "Select"
      expect(page).to have_content
      "#{user.username.capitalize} is already a registered collaborator."
    end
  end
end
