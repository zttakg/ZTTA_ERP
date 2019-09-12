class ChangeRolePermission < ActiveRecord::Migration[5.2]
  def change
    remove_column :roles, :permission
    add_column :roles, :permission, :json, default: {}
  end
end
