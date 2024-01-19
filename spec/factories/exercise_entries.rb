FactoryBot.define do
  factory :exercise_entry do
    goal { "MyString" }
    exercise_type { 1 }
    total_minutes { 1 }
    date { "2024-01-18" }
    patient { nil }
  end
end
