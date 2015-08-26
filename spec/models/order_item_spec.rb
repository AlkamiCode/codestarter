require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  before do
    @user = User.create!(username: "mitch", password: "password", role: 0)
    @item = Item.create!(title: "dinosaur", description: "aksdhk", price: 3)
    @order = Order.create!(user_id: @user.id, status: 0)
    @order_item = OrderItem.create!(quantity: 2, item_id: @item.id, order_id: @order.id)
  end

  xit "belongs to an item" do
    expect(@order_item.item_id).to eq(@item.id)
  end

  xit "belongs to an order" do
    expect(@order_item.order_id).to eq(@order.id)
  end

  xit "has a quantity" do
    expect(@order_item.quantity).to eq(2)
  end
end
