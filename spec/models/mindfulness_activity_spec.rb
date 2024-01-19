require 'rails_helper'

RSpec.describe MindfulnessActivity, type: :model do
  describe "relationships" do
    it { should belong_to(:patient) }
  end

  describe "validations" do
    it { should validate_presence_of(:activity) }
    it { should validate_presence_of(:total_minutes) }
    it { should validate_presence_of(:notes) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:patient_id) }
  end
end
