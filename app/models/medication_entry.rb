class MedicationEntry < ApplicationRecord
  belongs_to :patient

  validates_presence_of :name, 
                        :purpose, 
                        :dose, 
                        :schedule, 
                        :patient_id
end

