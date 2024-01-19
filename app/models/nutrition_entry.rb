class NutritionEntry < ApplicationRecord
  belongs_to :patient

  validates_presence_of :food_item, 
                        :calories, 
                        :number_of_servings, 
                        :healthy, 
                        :cups_of_water, 
                        :fruits_and_veg_servings, 
                        :correct_portion, 
                        :date, 
                        :patient_id
end
