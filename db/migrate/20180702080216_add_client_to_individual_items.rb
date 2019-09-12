class AddClientToIndividualItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :individual_items, :client, index: true
  end
end
