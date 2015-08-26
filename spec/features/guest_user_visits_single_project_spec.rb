require "rails_helper"

RSpec.describe "guest can visit single projects", type: :feature do
  context "a guest user" do
    let!(:project) { Fabricate(:project) }
    let!(:project_2) { Fabricate(:project, name: "second name") }
    let!(:project_3) { Fabricate(:project, name: "third name") }
    let!(:project_4) { Fabricate(:project, name: "fourth name") }

    it "can visit a single project" do
      visit projects_path

      first(:link, "View Project").click
      expect(current_path).to eq project_path(project)

      within(".header") do
        expect(page).to have_content "CodeStarter"
        expect(page).to have_link "Sign up"
        expect(page).to have_link "Login"
      end

      within ".project-details" do
        within ".col-md-4" do
          expect(page).to have_content "$200.00"
          expect(page).to have_content "pledged of $500.00 goal"
        end
      end
    end
  end
end
