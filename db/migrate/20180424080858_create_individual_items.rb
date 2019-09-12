class CreateIndividualItems < ActiveRecord::Migration[5.2]
  def change
    create_table :individual_items do |t|
      t.string :order_number
      t.string :name
      t.integer :count
      t.decimal :price
      t.decimal :full_price
      t.integer :status
      t.text :svg
      t.integer :thickness
      t.integer :cut_lenght
      t.string :detail_mass
      t.integer :detail_area
      t.integer :cut_type

      t.timestamps
    end
  end
end
