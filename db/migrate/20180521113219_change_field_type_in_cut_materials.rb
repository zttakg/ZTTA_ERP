class ChangeFieldTypeInCutMaterials < ActiveRecord::Migration[5.2]
  def change
    change_column :cut_materials, :hole_min, :float
  end
end
