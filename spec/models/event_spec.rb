require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:venue) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    # it { should validate_presence_of(:gate_fee) }
    # it { should validate_presence_of(:is_free) }
    # it { should validate_presence_of(:is_active) }
  end
end
