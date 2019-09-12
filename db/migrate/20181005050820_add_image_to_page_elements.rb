class AddImageToPageElements < ActiveRecord::Migration[5.2]
  def change
    add_column :page_elements, :image, :string
  end
end
