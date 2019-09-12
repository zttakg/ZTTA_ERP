class AddJsonColumnToDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :details, :json, :json
  end
end
