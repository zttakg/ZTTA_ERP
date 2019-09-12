class AddContactPersonEmailToIndividualOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :individual_orders, :contact_person_email, :string
  end
end
