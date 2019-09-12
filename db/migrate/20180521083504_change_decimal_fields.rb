class ChangeDecimalFields < ActiveRecord::Migration[5.2]
  def change
    change_column :cut_materials, :consumption, :decimal, precision: 10, scale: 2
    change_column :cut_materials, :pierce_price, :decimal, precision: 10, scale: 2
    change_column :details, :price, :decimal, precision: 10, scale: 2
    change_column :materials, :price_per_kg, :decimal, precision: 10, scale: 2
  end
end
