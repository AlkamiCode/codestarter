require "rails_helper"

RSpec.describe Cart, type: :model do
  let!(:project) { Fabricate(:project) }

  context "#items" do
    it "returns an array of CartItems" do
      data = Hash.new(0)
      data[project.id] = 2
      cart = Cart.new(data)

      expect(cart.items.first).to be_a_kind_of(CartItem)
    end
  end

  context "#data" do
    it "returns a hash with the item id and quantity" do
      input_data = {}
      input_data[project.id.to_s] = 2
      cart = Cart.new(input_data)
      expect(cart.data).to eq(project.id.to_s => 2)
    end
  end

  context "#add_item" do
    it "updates the data method when item is added to cart" do
      cart = Cart.new(nil)

      cart.add_item(project)
      expect(cart.data).to eq(project.id.to_s => 1)

      cart.add_item(project)
      expect(cart.data).to eq(project.id.to_s => 2)
    end
  end

  context "#remove_item" do
    it "updates the data method when item is removed from cart" do
      cart = Cart.new(nil)

      cart.add_item(project)
      cart.add_item(project)
      expect(cart.data).to eq(project.id.to_s => 2)

      cart.remove_item(project)
      expect(cart.data).to eq({})
    end

    it "does not permit zero or negative quantities for cart items" do
      cart = Cart.new(nil)

      cart.add_item(project)
      expect(cart.data).to eq(project.id.to_s => 1)

      cart.remove_item(project)
      expect(cart.data).not_to eq("1" => 0)
      expect(cart.data).to eq({})
    end
  end

  xcontext "cart total" do
    let!(:project_2) { Fabricate(:project) }
    let(:cart) { Cart.new(project.id => 1, project_2.id => 2) }

    it "calculates a cart total" do
      expect(cart.total).to eq(140)
    end
  end
end
