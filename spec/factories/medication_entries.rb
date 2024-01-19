FactoryBot.define do
  factory :medication_entry do
    name { Faker::Cannabis.strain }
    purpose { Faker::Games::Pokemon.move }
    dose { Faker::Cannabis.medical_use }
    schedule { Faker::Games::Pokemon.location }
    association :patient, factory: :patient
  end
end
