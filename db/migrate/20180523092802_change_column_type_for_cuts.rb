class ChangeColumnTypeForCuts < ActiveRecord::Migration[5.2]
  def change
    change_column :cuts, :height_max, :float
    change_column :cuts, :width_max, :float
  end
end
