require 'rails_helper'

RSpec.describe SocialInteraction, type: :model do
  describe "relationships" do
    it { should belong_to(:patient) }
  end

  describe "validations" do
    it { should validate_presence_of(:event_name)}
    it { should validate_presence_of(:activity_type) }
    it { should validate_presence_of(:social_rating) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:duration_in_minutes) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:patient_id) }

    it { should validate_inclusion_of(:alcohol_use).in_array([true, false]) }
    it { should validate_inclusion_of(:drug_use).in_array([true, false]) }
  end

  describe "enum" do
    it { should define_enum_for(:activity_type).with_values(alone: 1, with_one_other_person: 2, with_two_to_five_other_people: 3, with_six_to_ten_other_people: 4, with_more_than_ten_other_people: 5) }
    it { should define_enum_for(:social_rating).with_values(very_poor: 1, poor: 2, somewhat_poor: 3, moderate: 4, somewhat_good: 5, good: 6, very_good: 7)}
  end
end
