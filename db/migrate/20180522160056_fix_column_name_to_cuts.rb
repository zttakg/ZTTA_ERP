class FixColumnNameToCuts < ActiveRecord::Migration[5.2]
  def change
    rename_column :cuts, :m_consumables, :c_consumables
    rename_column :cuts, :c_fixed_laser, :c_fixed
  end
end
