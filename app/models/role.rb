class Role < ApplicationRecord
  has_many :employees

  def permissions
    AccessControl.permissions
  end
end
