class ChangeColumnsToMaterials < ActiveRecord::Migration[5.2]
  def change
    change_column :materials, :thickness, :float
    change_column :materials, :width_max, :float
    change_column :materials, :height_max, :float
  end
end
