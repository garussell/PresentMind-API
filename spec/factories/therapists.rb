FactoryBot.define do
  factory :therapist do
    name { Faker::Movies::Lebowski.character }
    email { Faker::Internet.email }
    office_number { Faker::PhoneNumber.cell_phone }
    specialization { Faker::Dessert.variety }
    years_in_practice { rand(1..20) }
    credentials { Faker::Educator.degree }
    bio { Faker::Movies::Lebowski.quote }
  end
end
