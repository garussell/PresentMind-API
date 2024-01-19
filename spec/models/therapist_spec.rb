require 'rails_helper'

RSpec.describe Therapist, type: :model do
  describe "relationships" do
    it { should have_many(:patients) }
    it { should have_many(:patterns).through(:patients) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:office_number) }
    it { should validate_presence_of(:specialization) }
    it { should validate_presence_of(:years_in_practice) }
    it { should validate_presence_of(:credentials) }
    it { should validate_presence_of(:bio) }
  end
end
