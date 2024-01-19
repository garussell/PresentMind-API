class Appointment < ApplicationRecord
  belongs_to :patient

  validates_presence_of :title, 
                        :description, 
                        :start_time, 
                        :end_time, 
                        :patient_id
end
