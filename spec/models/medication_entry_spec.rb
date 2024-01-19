require 'rails_helper'

RSpec.describe MedicationEntry, type: :model do
  describe "relationships" do
    it { should belong_to(:patient) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:purpose) }
    it { should validate_presence_of(:dose) }
    it { should validate_presence_of(:schedule) }
    it { should validate_presence_of(:patient_id) }
  end
end
