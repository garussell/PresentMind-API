FactoryBot.define do
  factory :journal_entry do
    title { "MyString" }
    content { "MyString" }
    date { "2024-01-18" }
    patient { nil }
  end
end
