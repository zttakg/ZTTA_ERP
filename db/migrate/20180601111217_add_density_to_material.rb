class AddDensityToMaterial < ActiveRecord::Migration[5.2]
  def change
    add_column :materials, :density, :float
  end
end
