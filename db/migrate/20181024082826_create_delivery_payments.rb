class CreateDeliveryPayments < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_payments do |t|
      t.string :title
      t.string :description
      t.text :content
      t.integer :condition

      t.timestamps
    end
  end
end
