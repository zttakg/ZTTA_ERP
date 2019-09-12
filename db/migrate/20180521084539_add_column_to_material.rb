class AddColumnToMaterial < ActiveRecord::Migration[5.2]
  def change
    add_column :materials, :in_stock, :boolean, default: true
  end
end
