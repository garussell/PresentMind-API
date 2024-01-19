class Therapist < ApplicationRecord
  has_many :patients, dependent: :destroy
  has_many :patterns, through: :patients

  validates_presence_of :name, 
                        :email, 
                        :office_number, 
                        :specialization, 
                        :years_in_practice, 
                        :credentials, 
                        :bio
end
