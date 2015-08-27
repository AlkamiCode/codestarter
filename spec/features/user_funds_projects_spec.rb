require "rails_helper"

RSpec.describe "user funds projects in one transaction", type: :feature do
  let!(:project) { Fabricate(:project) }
  let!(:user) { Fabricate(:user) }

  context "a registered user" do
    it "funds a project" do
      login_as(user, root_path)

      visit root_path
      click_link "Projects"
      expect(current_path).to eq projects_path

      first(:link, "Fund This Project").click
      click_link "Cart"

      within(".cart-options") do
        select 1500, from: "funding_amount"
        click_button "Set Amount"
      end

      expect(page).to have_content "$1,500.00"
      click_link "Checkout"

      expect(page).to have_content "Successfully funded projects!"
    end
  end

  context "a user that's not logged in" do
    it "has to log in to check out" do
      visit projects_path
      first(:link, "Fund This Project").click
      click_link "Cart"

      click_link "Log in to check out"
      login_as(user, "/cart")

      expect(page).to have_content "Welcome back, #{user.username}!"
      expect(current_path).to eq "/cart"
      click_link "Checkout"

      expect(page).to have_content "Successfully funded projects!"
      expect(current_path).to eq orders_path
    end
  end
end
