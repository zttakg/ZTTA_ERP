class AddColumnsToCut < ActiveRecord::Migration[5.2]
  def change
    add_column :cuts, :m_consumables, :decimal, precision: 10, scale: 2
    add_column :cuts, :c_fixed_laser, :decimal, precision: 10, scale: 2
    add_column :cuts, :height_max, :integer
    add_column :cuts, :width_max, :integer
  end
end
