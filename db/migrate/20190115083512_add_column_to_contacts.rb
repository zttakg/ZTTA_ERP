class AddColumnToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :whatsapp_link_for_metalware, :string
    add_column :contacts, :telegram_link_for_metalware, :string
  end
end
