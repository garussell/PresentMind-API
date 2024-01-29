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
end
