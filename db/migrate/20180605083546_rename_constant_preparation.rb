class RenameConstantPreparation < ActiveRecord::Migration[5.2]
  def change
    rename_column :constants, :material_preparation_time, :material_preparation_cost
  end
end
