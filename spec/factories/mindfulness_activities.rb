FactoryBot.define do
  factory :mindfulness_activity do
    activity { Faker::Games::Pokemon.move }
    total_minutes { rand(5..60) }
    notes { Faker::Quotes::Shakespeare.hamlet_quote }
    date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    mood_before { Faker::Number.between(from: 1, to: 7) }
    mood_after { Faker::Number.between(from: 1, to: 7) }
    stress_before { Faker::Number.between(from: 1, to: 7) }
    stress_after { Faker::Number.between(from: 1, to: 7) }
    
    association :patient, factory: :patient
  end
end
