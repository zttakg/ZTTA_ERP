class CreatePageElements < ActiveRecord::Migration[5.2]
  def change
    create_table :page_elements do |t|
      t.string :title
      t.text :content
      t.integer :element_type

      t.timestamps
    end
  end
end
