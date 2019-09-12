class AddTimestampToShipment < ActiveRecord::Migration[5.2]
  def change
    add_column :individual_item_shipments, :created_at, :datetime, null: false
    add_column :individual_item_shipments, :updated_at, :datetime, null: false
  end
end
