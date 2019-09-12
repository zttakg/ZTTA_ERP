class AddColumnsToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :telegram_id, :string
    add_column :employees, :status, :integer, default: 0
  end
end
