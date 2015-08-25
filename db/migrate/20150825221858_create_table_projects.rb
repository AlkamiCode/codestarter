class CreateTableProjects < ActiveRecord::Migration
  def change
    create_table :table_projects do |t|
      t.string :name
      t.string :description
      t.string :image
      t.integer :company_id
      t.integer :current_funding
      t.integer :funding_goal
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
