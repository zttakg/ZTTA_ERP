class ChangeDefaultValueOfDiscountInClient < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:clients, :discount, 0)
  end
end
