require "rails_helper"

RSpec.describe "guest can visit a company's projects", type: :feature do
  context "as a guest user" do
    let!(:company) { Fabricate(:company) }
    let!(:project) { Fabricate(:project) }
    let!(:project_2) { Fabricate(:project, name: "second name") }
    let!(:project_3) { Fabricate(:project, name: "third name") }
    let!(:project_4) { Fabricate(:project, name: "fourth name") }

    it "can see the projects for a particular company" do
      visit company_projects_path(company)
      expect(page).to have_content "second name"
    end
  end
end
