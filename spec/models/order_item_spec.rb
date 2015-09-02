require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let!(:user) { Fabricate(:user, roles: %w(registered_user)) }
  let!(:project) { Fabricate(:project) }
  let!(:company) { Fabricate(:company) }
  let!(:order) { Order.create!(user_id: user.id) }
  let!(:order_item) { OrderItem.create!(funding_amount: 200, project_id: project.id, order_id: order.id, company_id: company.id) }

  it "belongs to a project" do
    expect(order_item.project_id).to eq(project.id)
  end

  it "belongs to a company" do
    expect(order_item.company_id).to eq(company.id)
  end

  it "belongs to an order" do
    expect(order_item.order_id).to eq(order.id)
  end

  it "has a funding amount" do
    expect(order_item.funding_amount).to eq(200)
  end
end
