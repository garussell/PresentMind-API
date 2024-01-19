FactoryBot.define do
  factory :nutrition_entry do
    food_item { "MyString" }
    number_of_servings { 1 }
    healthy { false }
    cups_of_water { 1 }
    fruits_and_veg_servings { 1 }
    correct_portion { false }
    data { "2024-01-18" }
    patient { nil }
  end
end
