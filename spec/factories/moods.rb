FactoryBot.define do
  factory :mood do
    current_mood_scale { rand(1..7) }
    stress_level_scale { rand(1..7) }
    notes { Faker::Emotion.noun }
    date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    association :patient, factory: :patient
  end
end
