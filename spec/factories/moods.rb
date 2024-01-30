FactoryBot.define do
  factory :mood do
    current_mood_scale { rand(1..7) }
    stress_level_scale { rand(1..7) }

    association :patient, factory: :patient
  end
end
