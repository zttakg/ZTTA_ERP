class Service < ApplicationRecord
  mount_uploader :cover, CoverUploader
  mount_uploader :svg, CoverUploader

  validates_presence_of :title, :description
end
