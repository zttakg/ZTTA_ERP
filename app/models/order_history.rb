class OrderHistory < ApplicationRecord
  belongs_to :individual_order
  belongs_to :employee, optional: true
end
