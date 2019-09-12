class IndividualOrder < ApplicationRecord
  include TemirtulparHelper::Model::IndividualOrder

  def self.filter_statuses
    Hash[STATUSES.map.with_index.to_a]
  end

  def self.filter_person_types
    Hash[PERSON_TYPE.map.with_index.to_a]
  end

  sample_filter(
    {
      id: { type: :number },
      name: { type: :string },
      last_name: { type: :string },
      person_type: { type: :list, values: filter_person_types },
      status: { type: :list, values: filter_statuses },
      created_at: { type: :date },
      updated_at: { type: :date },
      sort: {
        type: :sorting,
        values: [:id, :name, :last_name, :created_at, :updated_at],
        default_value: 'updated_at_desc',
        hidden_input: true
      }
    }
  )

  has_many :individual_items
  has_many :order_histories

  belongs_to :client

  enum person_type: PERSON_TYPE
  enum payment: PAYMENT
  enum delivery_method: DELIVERY_METHODS
  enum status: STATUSES

  def shipped?
    in_progress?
  end
end
