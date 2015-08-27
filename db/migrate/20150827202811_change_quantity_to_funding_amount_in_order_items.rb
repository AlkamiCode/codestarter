class ChangeQuantityToFundingAmountInOrderItems < ActiveRecord::Migration
  def change
    rename_column :order_items, :quantity, :funding_amount
  end
end
