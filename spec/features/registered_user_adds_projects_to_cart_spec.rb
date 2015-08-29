require "rails_helper"

RSpec.describe "user adds projects to cart", type: :feature do
  context "a registered user with no items in the cart" do
    let!(:project) { Fabricate(:project) }
    let!(:project_2) { Fabricate(:project) }
    let!(:project_3) { Fabricate(:project) }
    let!(:project_4) { Fabricate(:project) }
    let!(:company) { Fabricate(:company) }

    it "adds items to cart" do
      visit root_path
      click_link "Projects"
      expect(page).to have_content "Sample Project"

      first(:link, "Fund This Project").click
      expect(current_path).to eq projects_path

      within("#mainNav") do
        expect(page).to have_content "1"
      end

      expect(page).to have_css(".fa-shopping-cart")
      page.find("a[href='/cart']").click
      expect(current_path).to eq cart_path
      expect(page).to have_content "Sample Project"
    end

    it "can set funding amount for projects in cart" do
      visit root_path
      click_link "Projects"
      first(:link, "Fund This Project").click
      page.find("a[href='/cart']").click
      expect(current_path).to eq cart_path
    end

    it "can be redirected to view the individual project" do
      visit projects_path
      first(:link, "Fund This Project").click

      first(:link, "View Project").click
      expect(current_path).to eq project_path(project)
    end
  end
end
