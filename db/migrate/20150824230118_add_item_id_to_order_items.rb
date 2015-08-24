class AddItemIdToOrderItems < ActiveRecord::Migration
  def change
    change_table :order_items do |t|
      t.references :item, index: true, foreign_key: true
    end
  end
end
