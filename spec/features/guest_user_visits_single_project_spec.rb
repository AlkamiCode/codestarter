require "rails_helper"

RSpec.describe "guest can visit single projects", type: :feature do
  context "a guest user" do
    let!(:project) { Fabricate(:project) }

    it "can visit a single project" do
      visit projects_path

      click_link "Sample Project"
      expect(current_path).to eq project_path(project)

      within(".header") do
        expect(page).to have_content "CodeStarter"
        expect(page).to have_link "Sign Up"
        expect(page).to have_link "Login"
      end

      within ".project-details" do
        within ".col-md-4" do
          expect(page).to have_content "265 backers"
          expect(page).to have_content "$1000 current funding"
          expect(page).to have_content "$2000 pledged goal"
        end
      end
    end
  end
end
