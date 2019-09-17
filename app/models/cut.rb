class Cut < ApplicationRecord
  has_many :cut_materials

  validates :name,
            :consumable_cost,
            :overhead_cost,
            :width_max,
            :height_max,
            presence: true

  validates :name, format: {with: /^[_\sa-zA-Z\u0400-\u04FF0-9()-.]+$/, message: 'Только буквы, цифры, нижнее подчёркивание, скобки и точка.', multiline: true}


  accepts_nested_attributes_for :cut_materials
end
