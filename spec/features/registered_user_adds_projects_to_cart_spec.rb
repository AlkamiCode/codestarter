require "rails_helper"

RSpec.describe "user adds projects to cart", type: :feature do
  context "a registered user with no items in the cart" do
    let!(:project) { Fabricate(:project) }
    # let!(:company) { Fabricate(:company) }

    it "adds items to cart" do
      visit projects_path
      expect(page).to have_content "Sample Project"

      click_link "Add to Cart"
      expect(current_path).to eq cart_items_path

      within(".nav navbar-nav navbar-right") do
        expect(page).to have_content "1"
      end
      binding.pry
      click_link "Cart"
      expect(current_path).to eq cart_projects_path
      expect(page).to have_content "Sample Project"
      expect(page).to have_content ""
    end
  end
end
