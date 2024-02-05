FactoryBot.define do
  factory :medication_entry do
    name { Faker::Cannabis.strain }
    purpose { Faker::Games::Pokemon.move }
    dose { Faker::Cannabis.medical_use }
    schedule { Faker::Games::Pokemon.location }
    mood_before { Faker::Number.between(from: 1, to: 7) }
    mood_after { Faker::Number.between(from: 1, to: 7) }
    stress_before { Faker::Number.between(from: 1, to: 7) }
    stress_after { Faker::Number.between(from: 1, to: 7) }
    
    association :patient, factory: :patient
  end
end
