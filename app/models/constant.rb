class Constant < ApplicationRecord
  validates :margin,
            :machine_preparation_time,
            :material_preparation_cost,
            :programming_cost,
            presence: true
end
