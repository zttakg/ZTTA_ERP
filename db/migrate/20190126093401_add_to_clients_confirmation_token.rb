class AddToClientsConfirmationToken < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :confirmation_token, :string
  end
end
