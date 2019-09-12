class ClearPrefixesForConstants < ActiveRecord::Migration[5.2]
  def change
    rename_column :constants, :k_margin, :margin
    rename_column :constants, :t_machine_preparation, :machine_preparation_time
    rename_column :constants, :c_material_preparation, :material_preparation_time
    rename_column :constants, :c_programming, :programming_cost
    rename_column :cuts, :c_consumables, :consumable_cost
    rename_column :cuts, :c_fixed, :overhead_cost
  end
end
