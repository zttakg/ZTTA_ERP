class ChangePricePercision < ActiveRecord::Migration[5.2]
  def change
    change_column :details, :price, :decimal
    change_column :individual_items, :price, :decimal
  end
end
