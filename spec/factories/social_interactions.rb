FactoryBot.define do
  factory :social_interaction do
    event_name { Faker::Games::ClashOfClans.troop }
    activity_type { rand(1..5) }
    social_rating { rand(1..7) }
    location { Faker::Games::ClashOfClans.defensive_building }
    duration_in_minutes { rand(1..120) }
    date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    alcohol_use { true }
    drug_use { true }
    mood_before { Faker::Number.between(from: 1, to: 7) }
    mood_after { Faker::Number.between(from: 1, to: 7) }
    stress_before { Faker::Number.between(from: 1, to: 7) }
    stress_after { Faker::Number.between(from: 1, to: 7) }
    
    association :patient, factory: :patient
  end
end
