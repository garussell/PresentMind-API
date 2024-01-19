require 'rails_helper'

RSpec.describe JournalEntry, type: :model do
  describe "relationships" do
    it { should belong_to(:patient) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:patient_id) }
  end
end
