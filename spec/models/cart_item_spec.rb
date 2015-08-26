require "rails_helper"

RSpec.describe CartItem, type: :model do
  xit "returns the title of the item" do
    item = Item.new(title: "Item 1")
    cart_item = CartItem.new(item)
    expect(cart_item.title).to eq("Item 1")
  end

  xit "returns the description of the item" do
    item = Item.new(description: "description")
    cart_item = CartItem.new(item)
    expect(cart_item.description).to eq("description")
  end

  xit "returns the price of the item" do
    item = Item.new(price: 400)
    cart_item = CartItem.new(item)
    expect(cart_item.price).to eq(400)
  end

  xit "returns the image of the item" do
    item = Item.new(image: "some url")
    cart_item = CartItem.new(item)
    expect(cart_item.image).to eq("some url")
  end

  xit "returns the item quantity" do
    item = Item.new(title: "Parka")
    cart_item = CartItem.new(item, 2)
    expect(cart_item.quantity).to eq(2)
  end

  xit "defaults the item quantity to 0" do
    item = Item.new(title: "Parka")
    cart_item = CartItem.new(item)
    expect(cart_item.quantity).to eq(0)
  end
end
