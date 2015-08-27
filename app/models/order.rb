class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :projects, through: :order_items
  before_create :create_from_cart

  enum status: %w(ordered paid cancelled completed)

  attr_accessor :cart_data

  def total
    order_items.inject(0) do |subtotal, order_item|
      subtotal + order_item.funding_amount
    end
  end

  private

  def create_from_cart
    if cart_data
      cart_data.each do |project_id, funding_amount|
        company_id = Project.find(project_id).company_id
        order_items.build(funding_amount: funding_amount,
          project_id: project_id.to_i, order_id: id, company_id: company_id)
      end
    end
  end
end
