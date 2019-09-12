class AddDetailFields < ActiveRecord::Migration[5.2]
  def change
    add_reference :details, :client, index: true
    add_column :details, :load_type, :integer
    add_column :details, :status, :integer
    add_column :details, :attachment, :string
    add_column :details, :width, :integer
    add_column :details, :height, :integer
    add_reference :details, :cut_material, index: true
    add_column :details, :count, :integer
    add_column :details, :cut_length, :integer
    add_column :details, :area, :integer
    add_column :details, :mass, :integer
    add_column :details, :holes_count, :integer
    add_column :details, :preparation_days, :integer
    add_column :details, :price, :decimal, precision: 8, scale: 2

    add_index :details, [:name, :client_id], unique: true
  end
end
