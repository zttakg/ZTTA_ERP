class AddProgrammingTimeToConstant < ActiveRecord::Migration[5.2]
  def change
    add_column :constants, :programming_time, :float
  end
end
