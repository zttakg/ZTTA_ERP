class Employee < ApplicationRecord
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  sample_filter(
    id: {type: :number},
    name: {type: :string},
    email: {type: :string},
    phone_number: {type: :string},
    branch: {type: :string},
    sort: {
      type: :sorting,
      values: [:id, :name, :email, :branch],
      default_value: 'id_asc',
      hidden_input: true
    }
  )

  belongs_to :role

  enum status: [:active, :blocked]

  scope :without_current, ->(current_employee) {where.not(id: current_employee.id)}

  validates :email, presence: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :phone_number, presence: true, format: {with: /\A\d{8,9}\z/}
  validates :password, format: {without: /\p{Cyrillic}+/, message: 'Без кириллицы'}

  def allowed_to?(action, project_module = nil)
    return true if admin?
    AccessControl.allowed_actions(action, role, project_module)
  end

  def generate_sms_code!
    code = rand(100_000..999_999)
    self.update_column(:reset_password_token, code)
  end

  def generate_password_token!
    self.update_column(:reset_password_token, Devise.friendly_token)
  end
end
