require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:valid_attributes) { attributes_for(:user) }

  describe 'POST /signup' do
    let(:user) { build(:user) }
    let(:headers) { { "Content-Type" => "application/json" } }

    context 'when valid request' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json_response[:message]).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json_response[:auth_token]).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json_response[:error])
          .to match(/Invalid credentials/)
      end
    end

    context 'when invalid request for existing account' do
      let(:user_two) { create :user_two }
      before { post '/signup', params: { first_name: user_two.first_name, last_name: user_two.last_name, 
                        email: user_two.email, password: user_two.password }.to_json, headers: headers }

      it 'does not create user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json_response[:error]).to match(/Account already exists/)
      end
    end
  end

  describe 'GET /users' do
    let(:user) { create(:user) }
    let(:headers) do
      {
        "Authorization" => token_generator(user.id),
        "Content-Type" => "application/json"
      }
    end
    let(:admin) { create(:admin) }
    let(:admin_headers) do
      {
        "Authorization" => token_generator(admin.id),
        "Content-Type" => "application/json"
      }
    end

    context 'when admin makes valid request' do
      before { get '/users', headers: admin_headers }

      it 'return an ok status' do
        expect(response).to have_http_status(200)
      end

      it 'returns all the users' do
        expect(json_response[:users].length).to eq(1)
      end
    end

    context 'when a user tries to fetch all users' do
      before { get '/users', headers: headers }

      it 'return an error status' do
        expect(response).to have_http_status(403)
      end

      it 'returns an error message' do
        expect(json_response[:error]).to eq("Unauthorized request")
      end
    end

  end

  describe 'GET /users/:user_id' do
    let(:user) { create(:user) }
    let(:headers) do
      {
        "Authorization" => token_generator(user.id),
        "Content-Type" => "application/json"
      }
    end
    let(:user_two) { create(:user_two) }
    let(:headers_two) do
      {
        "Authorization" => token_generator(user_two.id),
        "Content-Type" => "application/json"
      }
    end
    let(:admin) { create(:admin) }
    let(:admin_headers) do
      {
        "Authorization" => token_generator(admin.id),
        "Content-Type" => "application/json"
      }
    end

    context 'when admin makes valid request' do
      before { get "/users/#{user.id}", headers: admin_headers }

      it 'return an ok status' do
        expect(response).to have_http_status(200)
      end

      it 'returns the user data' do
        expect(json_response[:user][:id]).to eq(user.id)
      end
    end

    context 'when user makes valid request' do
      before { get "/users/#{user.id}", headers: headers }

      it 'return an ok status' do
        expect(response).to have_http_status(200)
      end

      it 'returns the user data' do
        expect(json_response[:user][:id]).to eq(user.id)
      end
    end

    context "when a user tries to fetch another user's profile" do
      before { get "/users/#{user.id}", headers: headers_two }

      it 'return an error status' do
        expect(response).to have_http_status(403)
      end

      it 'returns error message' do
        expect(json_response[:error]).to eq("Unauthorized request")
      end
    end
  end
  
  describe 'PUT /users/:user_id' do
    let(:user) { create(:user) }
    let(:headers) do
      {
        "Authorization" => token_generator(user.id),
        "Content-Type" => "application/json"
      }
    end
    let(:user_two) { create(:user_two) }
    let(:headers_two) do
      {
        "Authorization" => token_generator(user_two.id),
        "Content-Type" => "application/json"
      }
    end

    context 'when user makes valid request' do
      before { put "/users/#{user.id}", params: valid_attributes.to_json, headers: headers }

      it 'return an ok status' do
        expect(response).to have_http_status(200)
      end

      it 'returns the updated user' do
        expect(json_response[:user][:id]).to eq(user.id)
      end

      it 'returns success message' do
        expect(json_response[:message]).to eq("User account was updated successfully")
      end
    end

    context "when a user tries to update another user's profile" do
      before { put "/users/#{user.id}", params: valid_attributes.to_json, headers: headers_two }

      it 'return an error status' do
        expect(response).to have_http_status(403)
      end

      it 'returns error message' do
        expect(json_response[:error]).to eq("Unauthorized request")
      end
    end
  end
end