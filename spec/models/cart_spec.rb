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

  context "#add_project" do
    it "updates the data method when item is added to cart" do
      cart = Cart.new(nil)

      cart.add_project(project)
      expect(cart.data).to eq(project.id.to_s => 0)
    end
  end

  context "#remove_project" do
    it "updates the data method when item is removed from cart" do
      cart = Cart.new(nil)

      cart.add_project(project)
      cart.add_project(project)
      expect(cart.data).to eq(project.id.to_s => 0)

      cart.remove_project(project)
      expect(cart.data).to eq({})
    end
  end

  context "updates funding amount" do
    let(:cart) { Cart.new(project.id => 1) }

    it "updates the funding amount" do
      expect(cart.update_funding_amount(project.id, 300)).to eq(300)
    end
  end
end
