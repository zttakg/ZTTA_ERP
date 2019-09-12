class AddColumnsToIndividualOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :individual_orders, :production_date, :datetime
    add_column :individual_orders, :production_time, :float
  end
end
