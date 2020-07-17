require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  let!(:user) { create(:user) }
  let(:headers) { { "Content-Type" => "application/json" } }
  let(:valid_credentials) { { email: user.email, password: user.password }.to_json }
  let(:invalid_credentials) do
    {
      email: Faker::Internet.email,
      password: Faker::Internet.password
    }.to_json
  end

  describe 'POST /login' do
    context 'When request is valid' do
      before { post '/login', params: valid_credentials, headers: headers }

      it 'log in the user' do
        expect(response).to have_http_status(200)
      end

      it 'returns success message' do
        expect(json_response[:message]).to match(/Login was successful/)
      end

      it 'returns an authentication token' do
        expect(json_response[:auth_token]).not_to be_nil
      end
    end

    context 'When request is invalid' do
      before { post '/login', params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        expect(json_response[:error]).to match(/Invalid credentials/)
      end
    end
  end
end