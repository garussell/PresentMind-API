class ExerciseEntry < ApplicationRecord
  belongs_to :patient

  validates_presence_of :goal, 
                        :exercise_type, 
                        :total_minutes, 
                        :date, 
                        :patient_id
end
