class Patient < ApplicationRecord
  belongs_to :therapist

  has_many :appointments
  has_many :exercise_entries
  has_many :journal_entries
  has_many :medication_entries
  has_many :mindfulness_activities
  has_many :nutrition_entries
  has_many :sleep_entries
  has_many :social_interactions
  has_many :patterns

  validates_presence_of :name, 
                        :email, 
                        :dob, 
                        :phone, 
                        :address, 
                        :emergency_contact_name, 
                        :emergency_contact_number, 
                        :therapist_id

  after_create :create_default_pattern

  private

  def create_default_pattern
    Pattern.create(patient_id: self.id)
  end
end
