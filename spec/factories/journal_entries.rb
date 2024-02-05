FactoryBot.define do
  factory :journal_entry do
    title { Faker::Creature::Animal.name }
    content { Faker::Quote.famous_last_words }
    date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    mood_before { Faker::Number.between(from: 1, to: 7) }
    mood_after { Faker::Number.between(from: 1, to: 7) }
    stress_before { Faker::Number.between(from: 1, to: 7) }
    stress_after { Faker::Number.between(from: 1, to: 7) }
    
    association :patient, factory: :patient
  end
end
