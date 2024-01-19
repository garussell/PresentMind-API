class JournalEntry < ApplicationRecord
  belongs_to :patient

  validates_presence_of :title, 
                        :content, 
                        :date, 
                        :patient_id
end
