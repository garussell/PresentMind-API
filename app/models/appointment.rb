class Appointment < ApplicationRecord
  belongs_to :patient, dependent: :destroy

  validates_presence_of :title, 
                        :description, 
                        :start_time, 
                        :end_time, 
                        :patient_id
end
