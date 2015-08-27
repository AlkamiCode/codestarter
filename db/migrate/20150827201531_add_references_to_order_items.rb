class AddReferencesToOrderItems < ActiveRecord::Migration
  def change
    change_table :order_items do |t|
      t.references :company
      t.references :project
    end
  end
end
