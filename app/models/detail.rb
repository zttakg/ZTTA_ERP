class Detail < ApplicationRecord
  belongs_to :client
  belongs_to :cut_material

  enum load_type: %i[constructor custom]
  enum status: %i[not_send expects_assessed assessed not_assessed appraised]

  scope :custom_by_status, ->(status) { where(load_type: Detail.load_types[:custom], status: status) }
end
