FactoryBot.define do
  factory :pattern do
    start_date { "2024-01-18" }
    end_date { "2024-01-18" }
    average_mood { 1 }
    average_stress_level { 1 }
    average_stress_before_exercise { 1 }
    average_stress_after_exercise { 1 }
    average_mood_with_good_nutrition { 1 }
    average_mood_with_bad_nutrition { 1 }
    average_mood_before_journaling { 1 }
    average_mood_after_journaling { 1 }
    average_mood_before_mindfullness { 1 }
    average_mood_after_mindfullness { 1 }
    average_stress_before_mindfullness { 1 }
    average_stress_after_mindfullness { 1 }
    average_mood_before_social_int { 1 }
    average_mood_after_social_int { 1 }
    average_mood_before_meds { 1 }
    average_mood_after_meds { 1 }
    patient { nil }
  end
end
