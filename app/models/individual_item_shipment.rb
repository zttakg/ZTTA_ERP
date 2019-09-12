class IndividualItemShipment < ApplicationRecord
  belongs_to :employee

  validates :count, numericality: {only_integer: true, greater_than: 0}
  validates :individual_item_id, :employee_id, presence: true
end
