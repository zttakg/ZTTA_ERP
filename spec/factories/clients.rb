FactoryBot.define do
  factory :client do
    sequence(:email) { |n| "#{n}_#{FFaker::Internet.email}" }
    password 'password'
    name FFaker::Name.first_name + FFaker::Name.last_name
    phone_number '996555123123'
  end
end
