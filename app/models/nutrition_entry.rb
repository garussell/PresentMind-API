class NutritionEntry < ApplicationRecord
  belongs_to :patient, dependent: :destroy

  validates_presence_of :food_item, 
                        :calories, 
                        :number_of_servings, 
                        :cups_of_water, 
                        :fruits_and_veg_servings, 
                        :date, 
                        :patient_id

  validates :healthy, inclusion: { in: [true, false] }
  validates :correct_portion, inclusion: { in: [true, false] }
end
