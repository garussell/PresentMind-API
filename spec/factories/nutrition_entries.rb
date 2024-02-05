FactoryBot.define do
  factory :nutrition_entry do
    food_item { Faker::Food.dish }
    calories { rand(100..1000) }
    number_of_servings { rand(1..5) }
    healthy { true }
    cups_of_water { rand(1..10) }
    fruits_and_veg_servings { rand(1..10) }
    correct_portion { true }
    date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    mood_before { Faker::Number.between(from: 1, to: 7) }
    mood_after { Faker::Number.between(from: 1, to: 7) }
    stress_before { Faker::Number.between(from: 1, to: 7) }
    stress_after { Faker::Number.between(from: 1, to: 7) }

    association :patient, factory: :patient
  end
end
