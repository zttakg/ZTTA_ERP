class AddMinSumToConstant < ActiveRecord::Migration[5.2]
  def change
    add_column :constants, :min_order_sum, :integer
  end
end
