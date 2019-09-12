class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :name
      t.text :permission, array: true, default: []

      t.timestamps
    end
  end
end
