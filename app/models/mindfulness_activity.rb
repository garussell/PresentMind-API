class MindfulnessActivity < ApplicationRecord
  belongs_to :patient, dependent: :destroy

  validates_presence_of :activity, 
                        :total_minutes, 
                        :notes, 
                        :date, 
                        :patient_id
end
