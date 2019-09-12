class CreateIndividualCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :individual_carts do |t|
      t.references :client, foreign_key: true
      t.references :individual_item, foreign_key: true

      t.timestamps
    end
  end
end
