# spec/requests/users_spec.rb
require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:admin_user) { create(:admin_user) }
  let(:user) { build(:user) }
  let(:headers) { auth_valid_headers(admin_user) }
  let(:invalid_api_header) { auth_valid_headers(admin_user).except("ApiToken") }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end

  # User signup test suite
  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(200)
      end

      it 'returns user' do
        expect(json['email']).not_to be_nil
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end

    context 'when invalid api token' do
      before { post '/signup', params: valid_attributes.to_json, headers: invalid_api_header }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Api Not found/)
      end
    end
  end

  let(:admin_user) { create(:admin_user) }
  let(:existing_user) { create(:user) }
  let(:existing_user_attributes) do
    # send json payload
    { email: existing_user.email, password: existing_user.password }.to_json
  end
  let(:notexisting_user_attributes) do
    # send json payload
    { email: 'foo@bar.com', password: '12345678' }.to_json
  end
  let(:existing_user_invalid_pass_attributes) do
    # send json payload
    { email: existing_user.email, password: '12345678' }.to_json
  end

  # User signup test suite
  describe 'POST /auth/login' do
    context 'when valid request' do
      before { post '/auth/login', params: existing_user_attributes, headers: headers }

      it 'login user' do
        expect(response).to have_http_status(200)
      end

      it 'returns user' do
        expect(json['email']).not_to be_nil
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/auth/login', params: {}, headers: headers }

      it 'does not login user' do
        expect(response).to have_http_status(401)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Invalid credentials/)
      end
    end

    context 'when invalid user' do
      before { post '/auth/login', params: notexisting_user_attributes, headers: headers }

      it 'does not login user' do
        expect(response).to have_http_status(401)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/User not found/)
      end
    end

    context 'when invalid password' do
      before { post '/auth/login', params: existing_user_invalid_pass_attributes, headers: headers }

      it 'does not login user' do
        expect(response).to have_http_status(401)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Invalid Password/)
      end
    end

    context 'when invalid api token' do
      before { post '/signup', params: existing_user_invalid_pass_attributes, headers: invalid_api_header }

      it 'does not login user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Api Not found/)
      end
    end
  end

end