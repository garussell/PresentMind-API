FactoryBot.define do
  factory :appointment do
    title { Faker::Fantasy::Tolkien.character }
    description { Faker::Lorem.paragraph }
    start_time { Faker::Time.between(from: DateTime.now, to: DateTime.now + 30) }
    end_time { Faker::Time.between(from: DateTime.now + 31, to: DateTime.now + 60) }
    mood_before { 1 }
    mood_after { 7 }
    stress_before { 1 }
    stress_after { 5 }
    
    association :patient, factory: :patient
  end
end
