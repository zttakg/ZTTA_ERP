class AddDrawingColumnToIndividualItem < ActiveRecord::Migration[5.2]
  def change
    add_column :individual_items, :drawing, :string
  end
end
