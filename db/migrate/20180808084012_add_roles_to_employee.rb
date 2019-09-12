class AddRolesToEmployee < ActiveRecord::Migration[5.2]
  def change
    add_reference :employees, :role, foreign_key: true
    add_column :employees, :admin, :boolean, default: false
  end
end
