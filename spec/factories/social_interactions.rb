FactoryBot.define do
  factory :social_interaction do
    activity_type { "MyString" }
    number_of_participants { 1 }
    enjoyment_scale { 1 }
    location { "MyString" }
    duration_in_minutes { 1 }
    date { "2024-01-18" }
    patient { nil }
  end
end
