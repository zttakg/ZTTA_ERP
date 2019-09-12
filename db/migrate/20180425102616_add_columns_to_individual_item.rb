class AddColumnsToIndividualItem < ActiveRecord::Migration[5.2]
  def change
    add_column :individual_items, :json, :json
    add_column :individual_items, :load_type, :integer
  end
end
