class AddVideoLinkToPageElement < ActiveRecord::Migration[5.2]
  def change
    add_column :page_elements, :video_link, :string
  end
end
