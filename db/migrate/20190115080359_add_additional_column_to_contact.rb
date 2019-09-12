class AddAdditionalColumnToContact < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :fb_link, :string
    add_column :contacts, :instagram_link, :string
    add_column :contacts, :telegram_link, :string
    add_column :contacts, :whatsapp_link, :string
  end
end
