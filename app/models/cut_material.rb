class CutMaterial < ApplicationRecord
  belongs_to :material, inverse_of: :cut_materials
  belongs_to :cut

  has_many :individual_items

  validates :hole_min,
            :consumption,
            :speed,
            :pierce_price,
            presence: true
end
