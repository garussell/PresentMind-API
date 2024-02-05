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
    it { should define_enum_for(:mood_before).with_values({ mb_very_negative: 1, mb_moderately_negative: 2, mb_slightly_negative: 3, mb_neutral: 4, mb_slightly_positive: 5, mb_moderately_positive: 6, mb_very_positive: 7 }) }
    it { should define_enum_for(:mood_after).with_values({ ma_very_negative: 1, ma_moderately_negative: 2, ma_slightly_negative: 3, ma_neutral: 4, ma_slightly_positive: 5, ma_moderately_positive: 6, ma_very_positive: 7 }) } 
    it { should define_enum_for(:stress_before).with_values({ sb_very_stressed: 1, sb_moderately_stressed: 2, sb_slightly_stressed: 3, sb_moderate: 4, sb_slightly_relaxed: 5, sb_moderately_relaxed: 6, sb_very_relaxed: 7 }) }
    it { should define_enum_for(:stress_after).with_values({ sa_very_stressed: 1, sa_moderately_stressed: 2, sa_slightly_stressed: 3, sa_moderate: 4, sa_slightly_relaxed: 5, sa_moderately_relaxed: 6, sa_very_relaxed: 7 }) }
  end
end
