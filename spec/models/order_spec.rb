require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:user) { Fabricate(:user, roles: %w(registered_user)) }
  let!(:project) { Fabricate(:project) }
  let!(:company) { Fabricate(:company) }
  let!(:order) { Order.create!(user_id: user.id) }
  let!(:order_item) { OrderItem.create!(funding_amount: 200, project_id: project.id, order_id: order.id, company_id: company.id) }

  it "has a user" do
    expect(Order.first.user_id).to eq(user.id)
  end

  it "has a total" do
    expect(order.total).to eq(200)
  end
end
