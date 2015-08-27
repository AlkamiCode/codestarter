require "rails_helper"

RSpec.describe CartItem, type: :model do
  let!(:project) { Fabricate(:project) }

  it "returns the title of the item" do
    cart_item = CartItem.new(project)
    expect(cart_item.title).to eq("Item 1")
  end

  it "returns the description of the item" do
    cart_item = CartItem.new(project)
    expect(cart_item.description).to eq("description")
  end

  it "returns the price of the item" do
    cart_item = CartItem.new(project)
    expect(cart_item.price).to eq(400)
  end

  it "returns the image of the item" do
    cart_item = CartItem.new(project)
    expect(cart_item.image).to eq("some url")
  end

  it "returns the item quantity" do
    cart_item = CartItem.new(project, 2)
    expect(cart_item.quantity).to eq(2)
  end

  it "defaults the item quantity to 0" do
    cart_item = CartItem.new(project)
    expect(cart_item.quantity).to eq(0)
  end
end
