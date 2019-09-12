class CreateIndividualItemShipment < ActiveRecord::Migration[5.2]
  def change
    create_table :individual_item_shipments do |t|
      t.references :individual_item, foreign_key: true
      t.references :employee, foreign_key: true
      t.integer :count
    end
  end
end
