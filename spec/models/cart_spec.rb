require "rails_helper"

RSpec.describe Cart, type: :model do
  it "exists" do
    expect(Cart).to be
  end

  context "#items" do
    xit "returns an array of CartItems" do
      item = Item.create(title: "Item 2",
                         description: "Description 2",
                         price: 40,
                         image: "image url")
      data = Hash.new(0)
      data[item.id] = 2
      cart = Cart.new(data)

      expect(cart.items.first).to be_a_kind_of(CartItem)
    end
  end

  context "#data" do
    xit "returns a hash with the item id and quantity" do
      item = Item.create(title: "TRex Spex")
      input_data = {}
      input_data[item.id.to_s] = 2
      cart = Cart.new(input_data)
      expect(cart.data).to eq(item.id.to_s => 2)
    end
  end

  context "#add_item" do
    xit "updates the data method when item is added to cart" do
      item = Item.create(title: "TRex Spex")
      cart = Cart.new(nil)

      cart.add_item(item)
      expect(cart.data).to eq(item.id.to_s => 1)

      cart.add_item(item)
      expect(cart.data).to eq(item.id.to_s => 2)
    end
  end

  context "#remove_item" do
    xit "updates the data method when item is removed from cart" do
      item = Item.create(title: "TRex Spex")
      cart = Cart.new(nil)

      cart.add_item(item)
      cart.add_item(item)
      expect(cart.data).to eq(item.id.to_s => 2)

      cart.remove_item(item)
      expect(cart.data).to eq({})
    end

    xit "does not permit zero or negative quantities for cart items" do
      item = Item.create(title: "TRex Spex")
      cart = Cart.new(nil)

      cart.add_item(item)
      expect(cart.data).to eq(item.id.to_s => 1)

      cart.remove_item(item)
      expect(cart.data).not_to eq("1" => 0)
      expect(cart.data).to eq({})
    end
  end

  context "cart total" do
    let(:item1) do
      Item.create(title: "Item 1",
                  description: "Description 1",
                  price: 60,
                  image: "image url")
    end

    let(:item2) do
      Item.create(title: "Item 2",
                  description: "Description 2",
                  price: 40,
                  image: "image url")
    end

    let(:cart) { Cart.new(item1.id => 1, item2.id => 2) }

    xit "calculates a cart total" do
      expect(cart.total).to eq(140)
    end
  end
end
