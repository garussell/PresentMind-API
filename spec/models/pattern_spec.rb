require 'rails_helper'

RSpec.describe Pattern, type: :model do
  describe "relationships" do
    it { should belong_to(:patient) }
  end
end
