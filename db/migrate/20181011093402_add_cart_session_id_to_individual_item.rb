class AddCartSessionIdToIndividualItem < ActiveRecord::Migration[5.2]
  def change
    add_column :individual_items, :cart_session_id, :bigint
  end
end
