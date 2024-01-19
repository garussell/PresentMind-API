class JournalEntry < ApplicationRecord
  belongs_to :patient, dependent: :destroy

  validates_presence_of :title, 
                        :content, 
                        :date, 
                        :patient_id
end
