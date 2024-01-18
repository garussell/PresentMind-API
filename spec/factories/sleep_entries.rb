FactoryBot.define do
  factory :sleep_entry do
    quality_rating { 1 }
    total_hours { 1 }
    dream { false }
    notes { "MyString" }
    date { "2024-01-18" }
    patient { nil }
  end
end
