class AddTextColumnToDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :details, :description, :text
  end
end
