class AddButtonToPageElements < ActiveRecord::Migration[5.2]
  def change
    add_column :page_elements, :button, :boolean, default: false
  end
end
