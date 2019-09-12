class DeliveryPayment < ApplicationRecord
  enum condition: [:delivery, :payment]
end
