class CreateIndividualOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :individual_orders do |t|
      t.references :individual_item, foreign_key: true
      t.references :client, foreign_key: true
      t.decimal :total_price
      t.integer :status

      t.timestamps
    end
  end
end
