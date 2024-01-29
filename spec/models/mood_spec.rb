require 'rails_helper'

RSpec.describe Mood, type: :model do
  describe "relationships" do
    it { should belong_to(:patient) }
  end

  describe "validations" do
    it { should validate_presence_of(:current_mood_scale) }
    it { should validate_presence_of(:stress_level_scale) }
    it { should validate_presence_of(:patient_id) }
  end

  describe "enum" do
    it { should define_enum_for(:current_mood_scale).with_values(very_negative: 1, moderately_negative: 2, slightly_negative: 3, neutral: 4, slightly_positive: 5, moderately_positive: 6, very_positive: 7) }
    it { should define_enum_for(:stress_level_scale).with_values(very_stressed: 1, moderately_stressed: 2, slightly_stressed: 3, moderate: 4, slightly_relaxed: 5, moderately_relaxed: 6, very_relaxed: 7) }
  end
end
