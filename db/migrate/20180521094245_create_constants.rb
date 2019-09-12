class CreateConstants < ActiveRecord::Migration[5.2]
  def change
    create_table :constants do |t|
      t.float :k_margin
      t.float :t_machine_preparation
      t.decimal :c_material_preparation, precision: 10, scale: 2
      t.decimal :c_programming, precision: 10, scale: 2

      t.timestamps
    end
  end
end
