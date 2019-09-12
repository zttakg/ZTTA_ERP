class PageElement < ApplicationRecord
  mount_uploader :image, CoverUploader

  enum element_type: [:slide, :about_us, :user_agreement, :privacy_policy]
end
