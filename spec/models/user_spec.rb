require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Association" do
    it { should have_many(:events) }
  end

  describe "Validation" do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  end
end
