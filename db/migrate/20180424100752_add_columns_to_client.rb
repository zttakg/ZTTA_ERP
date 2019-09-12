class AddColumnsToClient < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :last_name, :string
    add_column :clients, :client_address, :string
    add_column :clients, :company_legal_address, :string
    add_column :clients, :city, :string
    add_column :clients, :company_city, :string
    add_column :clients, :company_BIC, :string
    add_column :clients, :bank_name, :string
    add_column :clients, :contact_person_name, :string
    add_column :clients, :contact_person_last_name, :string
    add_column :clients, :contact_person_phone_number, :string
    add_column :clients, :settlement_account, :string
    add_column :clients, :person_type, :integer, default: 0
  end
end
