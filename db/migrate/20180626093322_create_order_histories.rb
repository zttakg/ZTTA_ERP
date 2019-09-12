class CreateOrderHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :order_histories do |t|
      t.string :status
      t.references :individual_order, foreign_key: true

      t.timestamps
    end
  end
end
