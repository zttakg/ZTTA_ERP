class AddForeignKeyToDetails < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :details, :cut_materials
  end
end
