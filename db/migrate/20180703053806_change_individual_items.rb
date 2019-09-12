class ChangeIndividualItems < ActiveRecord::Migration[5.2]
  def change
    drop_table :individual_items

    create_table :individual_items do |t|
      t.references :client, foreign_key: true
      t.references :individual_order, foreign_key: true
      t.integer :status
      t.integer :load_type
      t.string :name
      t.integer :count
      t.text :svg
      t.json :json
      t.string :attachment
      t.text :description
      t.float :width
      t.float :height
      t.references :cut_material, foreign_key: true
      t.float :cut_length
      t.string :cut_name
      t.string :material_name
      t.float :material_thickness
      t.integer :holes_count
      t.float :area
      t.float :mass
      t.integer :preparation_days
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end

    change_column :individual_items, :id, :bigint
  end
end
