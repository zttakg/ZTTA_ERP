class ChangeColumnsToDetails < ActiveRecord::Migration[5.2]
  def change
    change_column :details, :width, :float
    change_column :details, :height, :float
    change_column :details, :cut_length, :float
    change_column :details, :area, :float
    change_column :details, :mass, :float
  end
end
