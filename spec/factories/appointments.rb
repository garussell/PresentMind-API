FactoryBot.define do
  factory :appointment do
    title { "MyString" }
    description { "MyString" }
    start_time { "2024-01-18 15:58:40" }
    end_time { "2024-01-18 15:58:40" }
    patient { nil }
  end
end
