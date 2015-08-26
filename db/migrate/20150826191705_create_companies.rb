class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end

    change_table :projects do |t|
      t.remove :company_id
      t.references :company, index: true, foreign_key: true
    end
  end
end
