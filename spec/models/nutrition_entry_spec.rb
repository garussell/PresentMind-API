require 'rails_helper'

RSpec.describe NutritionEntry, type: :model do
  describe "relationships" do
    it { should belong_to(:patient) }
  end

  describe "validations" do
    it { should validate_presence_of(:food_item) }
    it { should validate_presence_of(:calories) }
    it { should validate_presence_of(:number_of_servings) }
    it { should validate_presence_of(:healthy) }
    it { should validate_presence_of(:cups_of_water) }
    it { should validate_presence_of(:fruits_and_veg_servings) }
    it { should validate_presence_of(:correct_portion) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:patient_id) }
  end

end
