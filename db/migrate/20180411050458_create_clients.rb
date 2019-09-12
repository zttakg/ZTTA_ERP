class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :phone_number
      t.integer :discount
      t.string :company_name
      t.string :company_address
      t.string :company_INN
      t.string :company_OKPO

      t.timestamps
    end
  end
end
