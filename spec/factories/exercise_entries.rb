FactoryBot.define do
  factory :exercise_entry do
    goal { Faker::Fantasy::Tolkien.poem }
    exercise_type { rand(0..6) }
    total_minutes { rand(30..120) }
    date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    association :patient, factory: :patient
  end
end
