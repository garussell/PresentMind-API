require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe "relationships" do
    it { should belong_to(:therapist) }
    it { should have_many(:appointments) }
    it { should have_many(:exercise_entries) }
    it { should have_many(:journal_entries) }
    it { should have_many(:medication_entries) }
    it { should have_many(:mindfulness_activities) }
    it { should have_many(:nutrition_entries) }
    it { should have_many(:sleep_entries) }
    it { should have_many(:social_interactions) }
    it { should have_many(:patterns) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:dob) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:emergency_contact_name) }
    it { should validate_presence_of(:emergency_contact_number) }
    it { should validate_presence_of(:therapist_id) }
  end
end
