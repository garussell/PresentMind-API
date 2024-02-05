FactoryBot.define do
  factory :pattern do
    association :patient, factory: :patient
  end
end
