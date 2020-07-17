require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer do
  let(:user) { create(:user) }
  let(:event) { create(:event, user_id: user.id) }
  let(:event_two) { create(:event_two, user_id: user.id) }
  subject { described_class }



  it 'checks that response is not empty' do
    response = subject.new(user).to_json
    expect(response).not_to be_nil
  end

  it "checks that response returns a hash" do
    response = subject.new(user).to_json
    expect(JSON.parse(response)).to be_a Object
  end

  it "checks that response has user details" do
    response = subject.new(user).to_json
    expect(JSON.parse(response)["id"]).to eq(user.id)
  end

  it "checks that response contains events array" do
    response = subject.new(user).to_json
    expect(JSON.parse(response)["events"]).to be_a Object
  end
end
