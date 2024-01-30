require 'rails_helper'

RSpec.describe NutritionEntry, type: :model do
  describe "relationships" do
    it { should belong_to(:patient) }
  end

  describe "validations" do
    it { should validate_presence_of(:food_item) }
    it { should validate_presence_of(:calories) }
    it { should validate_presence_of(:number_of_servings) }
    it { should validate_presence_of(:cups_of_water) }
    it { should validate_presence_of(:fruits_and_veg_servings) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:patient_id) }

    it { should validate_inclusion_of(:healthy).in_array([true, false]) }
    it { should validate_inclusion_of(:correct_portion).in_array([true, false]) }
  end

end
