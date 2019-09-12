class ChangeOrdersHistory < ActiveRecord::Migration[5.2]
  def change
    remove_column :order_histories, :status
    add_reference :order_histories, :employee
    add_column :order_histories, :status_from, :string
    add_column :order_histories, :status_to, :string
  end
end
