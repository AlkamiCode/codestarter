class AddCategoryToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.references :category, index: true, foreign_key: true
    end
  end
end
