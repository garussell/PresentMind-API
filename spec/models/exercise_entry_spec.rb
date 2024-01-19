require 'rails_helper'

RSpec.describe ExerciseEntry, type: :model do
  describe "relationships" do
    it { should belong_to(:patient) }
  end

  describe "validations" do
    it { should validate_presence_of(:goal) }
    it { should validate_presence_of(:exercise_type) }
    it { should validate_presence_of(:total_minutes) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:patient_id) }
  end

  describe "enum" do
    it { should define_enum_for(:exercise_type).with_values([:cardio, :olympic_weightlifting, :plyometrics, :powerlifting, :strength, :stretching, :strongman]) }
  end
end
