FactoryBot.define do
  factory :mood do
    current_mood_scale { 1 }
    stress_level_scale { 1 }
    notes { "MyString" }
    date { "2024-01-18" }
    patient { nil }
  end
end
