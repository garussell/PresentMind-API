FactoryBot.define do
  factory :journal_entry do
    title { Faker::Creature::Animal.name }
    content { Faker::Quote.famous_last_words }
    date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    association :patient, factory: :patient
  end
end
