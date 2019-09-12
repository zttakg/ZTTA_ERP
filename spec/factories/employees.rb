FactoryBot.define do
  factory :employee do
    sequence(:email) { |n| "#{n}_#{FFaker::Internet.email}" }
    password 'password'
    name FFaker::Name.first_name + FFaker::Name.last_name
    role
  end
end
