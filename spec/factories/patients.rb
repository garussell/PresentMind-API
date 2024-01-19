FactoryBot.define do
  factory :patient do
    name { Faker::Fantasy::Tolkien.character }
    email { Faker::Internet.email }
    dob { Faker::Date.birthday(min_age: 18, max_age: 65) }
    phone { Faker::PhoneNumber.cell_phone }
    address { Faker::Address.full_address }
    emergency_contact_name { Faker::Fantasy::Tolkien.character }
    emergency_contact_number { Faker::PhoneNumber.cell_phone }
    association :therapist, factory: :therapist
  end
end
