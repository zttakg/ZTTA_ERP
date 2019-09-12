class AddCoverToServices < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :cover, :string
  end
end
