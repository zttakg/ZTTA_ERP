class City < ApplicationRecord
  validates :name, uniqueness: true, presence: true
end
