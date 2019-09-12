class CreateCutMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :cut_materials do |t|
      t.references :cut, foreign_key: true
      t.references :material, foreign_key: true
      t.integer :hole_min
      t.decimal :consumption, precision: 8, scale: 2
      t.integer :speed
      t.decimal :pierce_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
