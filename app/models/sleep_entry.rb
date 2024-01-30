class SleepEntry < ApplicationRecord
  belongs_to :patient, dependent: :destroy
  
  validates_presence_of :bed_time,
                        :quality_rating,
                        :total_hours,
                        :notes,
                        :date,
                        :patient_id

  validates :dream, inclusion: { in: [true, false] }
                        
  enum quality_rating: { very_poor: 1, poor: 2, somewhat_poor: 3, moderate: 4, somewhat_good: 5, good: 6, very_good: 7 }
end
