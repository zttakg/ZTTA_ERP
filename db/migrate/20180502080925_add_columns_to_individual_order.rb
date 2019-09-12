class AddColumnsToIndividualOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :individual_orders, :name, :string
    add_column :individual_orders, :last_name, :string
    add_column :individual_orders, :city, :string
    add_column :individual_orders, :client_address, :string
    add_column :individual_orders, :phone_number, :string
    add_column :individual_orders, :email, :string
    add_column :individual_orders, :company_OKPO, :string
    add_column :individual_orders, :company_name, :string
    add_column :individual_orders, :company_INN, :string
    add_column :individual_orders, :company_address, :string
    add_column :individual_orders, :company_legal_address, :string
    add_column :individual_orders, :company_city, :string
    add_column :individual_orders, :company_BIC, :string
    add_column :individual_orders, :bank_name, :string
    add_column :individual_orders, :contact_person_name, :string
    add_column :individual_orders, :contact_person_last_name, :string
    add_column :individual_orders, :contact_person_phone_number, :string
    add_column :individual_orders, :settlement_account, :string
    add_column :individual_orders, :person_type, :integer, default: 0
    add_column :individual_orders, :payment, :integer
    add_column :individual_orders, :delivery_method, :integer
    add_column :individual_orders, :comment, :text

    remove_reference :individual_orders, :individual_item, index: true
    add_reference :individual_items, :individual_order, index: true
  end
end
