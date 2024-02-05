class ExerciseEntry < ApplicationRecord
  belongs_to :patient, dependent: :destroy

  validates_presence_of :goal, 
                        :exercise_type, 
                        :total_minutes, 
                        :date, 
                        :patient_id

  # Categories are based on the 'exercises' endpoint from API Ninjas
  # As a separate but related feature, when a user selects an exercise type,
  # the app will display a list of exercises that match the selected type.
  # The user can then select an exercise from the list which will be accompanied
  # by instructions and other data from the api response.
  enum exercise_type: [:cardio, :olympic_weightlifting, :plyometrics, :powerlifting, :strength, :stretching, :strongman]
  enum mood_before: { mb_very_negative: 1, mb_moderately_negative: 2, mb_slightly_negative: 3, mb_neutral: 4, mb_slightly_positive: 5, mb_moderately_positive: 6, mb_very_positive: 7 }
  enum mood_after: { ma_very_negative: 1, ma_moderately_negative: 2, ma_slightly_negative: 3, ma_neutral: 4, ma_slightly_positive: 5, ma_moderately_positive: 6, ma_very_positive: 7 }
  enum stress_before: { sb_very_stressed: 1, sb_moderately_stressed: 2, sb_slightly_stressed: 3, sb_moderate: 4, sb_slightly_relaxed: 5, sb_moderately_relaxed: 6, sb_very_relaxed: 7 }
  enum stress_after: { sa_very_stressed: 1, sa_moderately_stressed: 2, sa_slightly_stressed: 3, sa_moderate: 4, sa_slightly_relaxed: 5, sa_moderately_relaxed: 6, sa_very_relaxed: 7 }
end
