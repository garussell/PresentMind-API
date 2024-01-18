FactoryBot.define do
  factory :medication_entry do
    name { "MyString" }
    purpose { "MyString" }
    dose { "MyString" }
    schedule { "MyString" }
    patient { nil }
  end
end
