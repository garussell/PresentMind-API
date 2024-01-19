FactoryBot.define do
  factory :pattern do
    start_date { Faker::Date.between(from: 1.year.ago, to: 1.week.ago) }
    end_date { Faker::Date.between(from: 1.week.ago, to: Date.today) }
    average_mood { rand(1..7) }
    average_stress_level { rand(1..7) }
    average_sleep_quality { rand(1..7) }
    average_sleep_hours { rand(1..12) }
    average_stress_before_exercise { rand(1..7) }
    average_stress_after_exercise { rand(1..7) }
    average_mood_with_good_nutrition { rand(1..7) }
    average_mood_with_bad_nutrition { rand(1..7) }
    average_mood_before_journaling { rand(1..7) }
    average_mood_after_journaling { rand(1..7) }
    average_mood_before_mindfullness { rand(1..7) }
    average_mood_after_mindfullness { rand(1..7) }
    average_stress_before_mindfullness { rand(1..7) }
    average_stress_after_mindfullness { rand(1..7) }
    average_mood_before_social_event { rand(1..7) }
    average_mood_after_social_event { rand(1..7) }
    average_mood_before_meds { rand(1..7) }
    average_mood_after_meds { rand(1..7) }
    association :patient, factory: :patient
  end
end
