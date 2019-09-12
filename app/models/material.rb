class Material < ApplicationRecord
  sample_filter(
    {
      name: { type: :string },
      thickness: { type: :number },
      width_max: { type: :number },
      height_max: { type: :number },
      sort: {
        type: :sorting,
        values: [:name, :thickness, :width_max, :height_max],
        default_value: 'thickness_asc',
        hidden_input: true
      }
    }
  )

  has_many :cut_materials, dependent: :destroy

  validates :name,
            :thickness,
            :price_per_kg,
            :width_max,
            :height_max,
            :density,
            presence: true

  accepts_nested_attributes_for :cut_materials
end
