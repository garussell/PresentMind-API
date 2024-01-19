FactoryBot.define do
  factory :mindfulness_activity do
    total_minutes { 1 }
    notes { "MyString" }
    date { "2024-01-18" }
    patient { nil }
  end
end
