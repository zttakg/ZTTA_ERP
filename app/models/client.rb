class Client < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :password, format: {without: /\p{Cyrillic}+/, message: ' не может содержать кириллицу'}

  sample_filter(
    id: {type: :number},
    name: {type: :string},
    email: {type: :string},
    phone_number: {type: :string},
    sort: {
      type: :sorting,
      values: [:id, :name, :email],
      default_value: 'id_asc',
      hidden_input: true
    }
  )

  has_many :individual_orders

  enum status: [:active, :banned]
  enum person_type: [:individual, :legal]
end
