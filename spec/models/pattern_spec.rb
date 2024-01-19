require 'rails_helper'

RSpec.describe Pattern, type: :model do
  describe "relationships" do
    it { should belong_to(:patient) }
  end

  describe "validations" do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:average_mood) }
    it { should validate_presence_of(:average_stress_level) }
    it { should validate_presence_of(:average_sleep_quality) }
    it { should validate_presence_of(:average_sleep_hours) }
    it { should validate_presence_of(:average_stress_before_exercise) }
    it { should validate_presence_of(:average_stress_after_exercise) }
    it { should validate_presence_of(:average_mood_with_good_nutrition) }
    it { should validate_presence_of(:average_mood_with_bad_nutrition) }
    it { should validate_presence_of(:average_mood_before_journaling) }
    it { should validate_presence_of(:average_mood_after_journaling) }
    it { should validate_presence_of(:average_mood_before_mindfulness) }
    it { should validate_presence_of(:average_mood_after_mindfulness) }
    it { should validate_presence_of(:average_stress_before_mindfulness) }
    it { should validate_presence_of(:average_stress_after_mindfulness) }
    it { should validate_presence_of(:average_mood_before_social_event) }
    it { should validate_presence_of(:average_mood_after_social_event) }
    it { should validate_presence_of(:average_mood_before_meds) }
    it { should validate_presence_of(:average_mood_after_meds) }
    it { should validate_presence_of(:patient_id) }
  end
end
