require "rails_helper"

RSpec.describe Category, type: :model do
  context "with valid attributes" do
    let!(:category) { Category.create(name: "hat stuff") }

    it "has a name" do
      expect(category.name).to eq("hat stuff")
    end

    it "creates a slug" do
      expect(category.slug).to eq("hat_stuff")
    end

    xit "has many items" do
      expect(category.items).to eq([])
    end
  end
end
