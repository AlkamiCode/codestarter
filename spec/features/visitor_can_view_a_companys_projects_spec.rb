require "rails_helper"

RSpec.describe "guest can visit a company's projects", type: :feature do
  context "as a guest user" do
    let!(:company) { Fabricate(:company) }
    let!(:company_2) { Fabricate(:company, name: "second company") }

    let!(:project) { Fabricate(:project, company: company) }
    let!(:project_2) { Fabricate(:project, name: "second name", company: company) }
    let!(:project_3) { Fabricate(:project, name: "third name", company: company_2) }
    let!(:project_4) { Fabricate(:project, name: "fourth name", company: company_2) }

    it "can see only the projects for a particular company" do
      visit root_path
      click_link "Companies"

      expect(current_path).to eq companies_path

      within "div.caption", text: "#{company.name}" do
        click_link "View Projects"
      end

      expect(current_path).to eq company_projects_path(company: company.url)
      expect(page).to have_content "Sample Project"
      expect(page).to have_content "second name"
      expect(page).not_to have_content "third name"
      expect(page).not_to have_content "fourth name"
    end
  end
end
