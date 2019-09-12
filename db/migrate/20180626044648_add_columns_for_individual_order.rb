class AddColumnsForIndividualOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :individual_orders, :delivery_address, :string
    add_column :individual_orders, :bank_address, :string
  end
end
