class ExerciseEntry < ApplicationRecord
  belongs_to :patient, dependent: :destroy

  validates_presence_of :goal, 
                        :exercise_type, 
                        :total_minutes, 
                        :date, 
                        :patient_id

  enum exercise_type: [:cardio, :olympic_weightlifting, :plyometrics, :powerlifting, :strength, :stretching, :strongman]
end
