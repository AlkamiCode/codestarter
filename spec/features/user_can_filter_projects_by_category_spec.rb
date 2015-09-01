require "rails_helper"

RSpec.describe "User Can Filter Projects by Category", type: :feature do
  context "as a user" do
    let!(:category) { Fabricate(:category) }
    let!(:project) { Fabricate(:project, category_id: category.id) }

    it "can filter projects via the navbar" do
      visit root_path
      click_on "Categories"
      click_on "Sample Category"

      expect(current_path).to eq category_path(id: category.slug)
      expect(page).to have_content "Sample Project"
    end
  end
end
