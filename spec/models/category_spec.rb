require "rails_helper"

RSpec.describe Category, type: :model do
  context "with valid attributes" do
    let!(:category) { Category.create(name: "hat stuff") }

    it "has a name" do
      expect(category.name).to eq("hat stuff")
    end

    it "creates a slug" do
      expect(category.slug).to eq("hat-stuff")
    end

    it "has many projects" do
      expect(category.projects).to eq([])
    end
  end
end
