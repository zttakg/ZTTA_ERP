class AddWorkTimeToConstant < ActiveRecord::Migration[5.2]
  def change
    add_column :constants, :work_time, :float
  end
end
