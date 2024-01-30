class Mood < ApplicationRecord
  belongs_to :patient, dependent: :destroy
  
  validates_presence_of :current_mood_scale, 
                        :stress_level_scale, 
                        :patient_id

  enum current_mood_scale: { very_negative: 1, moderately_negative: 2, slightly_negative: 3, neutral: 4, slightly_positive: 5, moderately_positive: 6, very_positive: 7 }
  enum stress_level_scale: { very_stressed: 1, moderately_stressed: 2, slightly_stressed: 3, moderate: 4, slightly_relaxed: 5, moderately_relaxed: 6, very_relaxed: 7 }
end
