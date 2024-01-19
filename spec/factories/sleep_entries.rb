FactoryBot.define do
  factory :sleep_entry do
    bed_time { Faker::Time.between(from: DateTime.now, to: DateTime.now + 30) }
    quality_rating { rand(1..7) }
    total_hours { rand(1..12) }
    dream { true }
    notes { Faker::Quotes::Rajnikanth.joke }
    date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    association :patient, factory: :patient
  end
end
