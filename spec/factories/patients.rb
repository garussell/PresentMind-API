FactoryBot.define do
  factory :patient do
    name { "MyString" }
    email { "MyString" }
    dob { "2024-01-18" }
    phone { "MyString" }
    address { "MyString" }
    emergency_contact_name { "MyString" }
    emergency_contact_number { "MyString" }
    therapist { nil }
  end
end
