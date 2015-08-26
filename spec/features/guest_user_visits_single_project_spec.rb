require "rails_helper"

RSpec.describe "guest can visit single projects", type: :feature do
  context "a guest user" do
    let!(:project) { Fabricate(:project) }

    it "can visit a single project" do
      visit project_path

      click_link "Sample Project"
      expect(current_path).to eq project_path(project)

      within(".navbar") do
        expect(page).to have_content "Sample Project"
        expect(page).to have_button "Login"
      end

      within "content" do
        within "card" do
          expect(page).to have_content "Sample Project"
          expect(page).to have_content "Current funding: 200"
          expect(page).to have_content "Funding goal: 500"
          expect(page).to have_content "Created by Sample Company"
        end
      end
    end
  end
end
