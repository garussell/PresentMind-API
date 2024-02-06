FactoryBot.define do
  factory :appointment do
    title { Faker::Fantasy::Tolkien.character }
    description { Faker::Lorem.paragraph }
    start_time { Faker::Time.between(from: DateTime.now, to: DateTime.now + 30) }
    end_time { Faker::Time.between(from: DateTime.now + 31, to: DateTime.now + 60) }
    mood_before { Faker::Number.between(from: 1, to: 7) }
    mood_after { Faker::Number.between(from: 1, to: 7) }
    stress_before { Faker::Number.between(from: 1, to: 7) }
    stress_after { Faker::Number.between(from: 1, to: 7) }
    
    association :patient, factory: :patient
  end
end
