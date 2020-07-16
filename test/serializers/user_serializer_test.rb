require 'test_helper'

class UserSerializerTest < ActionDispatch::IntegrationTest
  describe UserSerializer do
    let(:user){ User.create(first_name: "Test", last_name: "User", 
                                  email: "test@user.com", password: "password") }
    let(:user2){ User.create(first_name: "Test", last_name: "User2", 
                                    email: "test2@user.com", password: "password") }

    let(:event){ Event.create(user: user, name: "new event", description: "this is a new description", venue: "my house",
                                  start_time: "2020-07-18 10:08:37.180325", end_time: "2020-07-18 12:08:37.180325",
                                  is_free: true) }
    let(:event2){ Event.create(user: user, name: "new event", description: "this is a new description", venue: "my house",
                              start_time: "2020-07-18 10:08:37.180325", end_time: "2020-07-18 12:08:37.180325",
                              is_free: false, gate_fee: 2500) }

    it 'returns all attributes' do
      serializer = UserSerializer.new(user)
      fields = [:id, :first_name, :last_name, :email, :phone_number, :events]
      assert_equal fields, serializer.attributes.keys
    end

    it 'checks that the response is not empty' do
      serializer = UserSerializer.new(user)
      response = serializer.to_json()
      assert_not_empty response
    end
  end
end
