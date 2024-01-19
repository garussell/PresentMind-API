class MindfulnessActivity < ApplicationRecord
  belongs_to :patient

  validates_presence_of :activity, 
                        :total_minutes, 
                        :notes, 
                        :date, 
                        :patient_id
end
