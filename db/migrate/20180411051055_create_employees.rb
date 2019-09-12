class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :branch
      t.string :phone_number

      t.timestamps
    end
  end
end
