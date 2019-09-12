class DeleteIndividualCarts < ActiveRecord::Migration[5.2]
  def change
    drop_table :individual_carts
  end
end
