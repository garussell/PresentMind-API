require 'rails_helper'

RSpec.describe SleepEntry, type: :model do
  describe "relationships" do
    it { should belong_to(:patient) }
  end

  describe "validations" do
    it { should validate_presence_of(:bed_time) }
    it { should validate_presence_of(:quality_rating) }
    it { should validate_presence_of(:total_hours) }
    it { should validate_presence_of(:notes) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:patient_id) }

    it { should validate_inclusion_of(:dream).in_array([true, false]) }
  end

  describe "enum" do
    it { should define_enum_for(:quality_rating).with_values(very_poor: 1, poor: 2, somewhat_poor: 3, moderate: 4, somewhat_good: 5, good: 6, very_good: 7) }  
  end
end
