require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @user = User.create!(username: "mitch", password: "password", role: 0)
    @item = Item.create!(title: "dinosaur", description: "aksdhk", price: 3)
    @order = Order.create!(user_id: @user.id, status: 0)
    @order_item = OrderItem.create!(quantity: 2, item_id: @item.id, order_id: @order.id)
  end

  xit "has a user" do
    expect(Order.first.user_id).to eq(@user.id)
  end

  xit "has a total" do
    expect(@order.total).to eq(6)
  end

  xit "has a status" do
    expect(@order.status).to eq("ordered")
  end
end
