class SocialInteraction < ApplicationRecord
  belongs_to :patient, dependent: :destroy
  
  validates_presence_of :event_name,
                        :activity_type, 
                        :social_rating, 
                        :location, 
                        :duration_in_minutes, 
                        :date, 
                        :patient_id

  validates :alcohol_use, inclusion: { in: [true, false] }
  validates :drug_use, inclusion: { in: [true, false] }

  enum activity_type: { alone: 1, with_one_other_person: 2, with_two_to_five_other_people: 3, with_six_to_ten_other_people: 4, with_more_than_ten_other_people: 5 }
  enum social_rating: { very_poor: 1, poor: 2, somewhat_poor: 3, moderate: 4, somewhat_good: 5, good: 6, very_good: 7 }
end
