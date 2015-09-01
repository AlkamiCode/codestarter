require "rails_helper"

RSpec.describe "company admin creates a project" do
  context "a company admin" do
    let!(:company) { Fabricate(:company) }

    let!(:user) { Fabricate(:user, company_id: company.id, roles: %w(company_admin)) }

    let!(:project) { Fabricate.build(:project) }
    let!(:project_1) { Fabricate(:project) }
    let!(:project_2) { Fabricate(:project) }
    let!(:project_3) { Fabricate(:project) }
    let!(:project_4) { Fabricate(:project) }

    it "creates a project" do
      login_as(user, root_path)

      click_link "Account"
      click_link "#{company.name}'s dashboard"
      click_link "Create Project"

      expect(current_path).to eq new_company_project_path(company: company.url)

      within(".new-project-form") do
        fill_in "Name", with: project.name
        fill_in "Description", with: project.description
        fill_in "Funding goal", with: project.funding_goal
        fill_in "Image", with: project.image

        click_button "Create"
      end

      expect(current_path).to eq company_project_path(company: company.url,
                                                      id: Project.last.id)
    end
  end

  context "a non company admin" do
    let!(:company) { Fabricate(:company) }
    let!(:user) { Fabricate(:user) }

    it "can not create a project" do
      login_as(user, root_path)

      click_link "Account"
      expect(page).to_not have_content "Create Project"

      visit "/#{company.url}/projects/new"
      expect(page).to have_content "You are not authorized to access this page."
      expect(current_path).to eq root_path
    end
  end

  context "a different company admin" do
    let!(:company) { Fabricate(:company) }
    let!(:company_2) { Fabricate(:company, name: "Different Company") }

    let!(:admin) { Fabricate(:user, company_id: company.id, roles: %w(company_admin)) }
    let!(:admin2) { Fabricate(:user,
                              username: "admin2",
                              company_id: company_2.id,
                              roles: %w(company_admin),
                              email: "admin2@email.com") }

    let!(:project) { Fabricate.build(:project) }
    let!(:project_1) { Fabricate(:project) }
    let!(:project_2) { Fabricate(:project) }
    let!(:project_3) { Fabricate(:project) }
    let!(:project_4) { Fabricate(:project) }

    it "can create a project for a their company" do
      login_as(admin2, root_path)

      click_link "Account"
      click_link "#{company_2.name}'s dashboard"
      click_link "Create Project"

      expect(current_path).to eq new_company_project_path(company: company_2.url)

      within(".new-project-form") do
        fill_in "Name", with: project.name
        fill_in "Description", with: project.description
        fill_in "Funding goal", with: project.funding_goal
        fill_in "Image", with: project.image

        click_button "Create"
      end

      expect(current_path).to eq company_project_path(company: company_2.url,
                                                      id: Project.last.id)
    end

    it "cannot create a project for a different company" do
      login_as(admin, root_path)

      visit "/#{company_2.url}/projects/new"
      expect(current_path).to eq root_path
      expect(page).to have_content "You are not authorized to view this page."
    end
  end
end
