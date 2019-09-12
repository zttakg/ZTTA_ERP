class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.string :name
      t.integer :thickness
      t.decimal :price_per_kg, precision: 8, scale: 2
      t.integer :width_max
      t.integer :height_max

      t.timestamps
    end
  end
end
