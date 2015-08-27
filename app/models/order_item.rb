class OrderItem < ActiveRecord::Base
  belongs_to :project
  belongs_to :order

  def sub_total
    item.final_price * quantity
  end
end
