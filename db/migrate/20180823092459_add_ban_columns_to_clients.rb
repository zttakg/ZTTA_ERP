class AddBanColumnsToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :banned_before, :datetime
    add_column :clients, :ban_reason, :text
  end
end
