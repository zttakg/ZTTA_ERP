class IndividualItem < ApplicationRecord
  belongs_to :individual_order, optional: true
  belongs_to :cut_material

  has_many :individual_item_shipments

  def total_shipment
    individual_item_shipments.sum(&:count)
  end
end
