class SocialInteraction < ApplicationRecord
  belongs_to :patient, dependent: :destroy
  
  validates_presence_of :event_name,
                        :activity_type, 
                        :social_rating, 
                        :location, 
                        :duration_in_minutes, 
                        :date, 
                        :patient_id

  validates :alcohol_use, inclusion: { in: [true, false] }
  validates :drug_use, inclusion: { in: [true, false] }

  enum activity_type: { alone: 1, with_one_other_person: 2, with_two_to_five_other_people: 3, with_six_to_ten_other_people: 4, with_more_than_ten_other_people: 5 }
  enum social_rating: { very_poor: 1, poor: 2, somewhat_poor: 3, moderate: 4, somewhat_good: 5, good: 6, very_good: 7 }
  enum mood_before: { mb_very_negative: 1, mb_moderately_negative: 2, mb_slightly_negative: 3, mb_neutral: 4, mb_slightly_positive: 5, mb_moderately_positive: 6, mb_very_positive: 7 }
  enum mood_after: { ma_very_negative: 1, ma_moderately_negative: 2, ma_slightly_negative: 3, ma_neutral: 4, ma_slightly_positive: 5, ma_moderately_positive: 6, ma_very_positive: 7 }
  enum stress_before: { sb_very_stressed: 1, sb_moderately_stressed: 2, sb_slightly_stressed: 3, sb_moderate: 4, sb_slightly_relaxed: 5, sb_moderately_relaxed: 6, sb_very_relaxed: 7 }
  enum stress_after: { sa_very_stressed: 1, sa_moderately_stressed: 2, sa_slightly_stressed: 3, sa_moderate: 4, sa_slightly_relaxed: 5, sa_moderately_relaxed: 6, sa_very_relaxed: 7 }
end
