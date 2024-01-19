class Pattern < ApplicationRecord
  belongs_to :patient, dependent: :destroy

  validates_presence_of :start_date, 
                        :end_date, 
                        :average_mood, 
                        :average_stress_level, 
                        :average_sleep_quality, 
                        :average_sleep_hours, 
                        :average_stress_before_exercise, 
                        :average_stress_after_exercise, 
                        :average_mood_with_good_nutrition, 
                        :average_mood_with_bad_nutrition, 
                        :average_mood_before_journaling, 
                        :average_mood_after_journaling, 
                        :average_mood_before_mindfulness, 
                        :average_mood_after_mindfulness, 
                        :average_stress_before_mindfulness, 
                        :average_stress_after_mindfulness, 
                        :average_mood_before_social_event, 
                        :average_mood_after_social_event, 
                        :average_mood_before_meds, 
                        :average_mood_after_meds, 
                        :patient_id
end
