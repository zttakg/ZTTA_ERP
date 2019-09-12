class AddSvgToServices < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :svg, :string
  end
end
