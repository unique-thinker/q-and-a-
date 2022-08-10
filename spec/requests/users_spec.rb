# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:users_path) { '/api/users' }
  let(:user) { build(:user) }
  let(:password) { user.password }
  let(:user_params) {
    { email: user.email, password:, password_confirmation: password }
  }
  let(:invalid_email_params) { user_params.merge(email: 'invalid_email') }
  let(:empty_email_params) { user_params.merge(email: '') }
  let(:mismatch_password_params) { user_params.merge(password: 'wrong_password') }
  let(:empty_password_params) { user_params.merge(password: '', password_confirmation: '') }

  describe 'POST /api/users' do
    context 'with valid params' do
      it 'should return 201' do
        post users_path, params: user_params.to_json, headers: api_headers
        expect(response).to have_http_status(201)
        expect(User.count).to eq 1
        expect(response_body[:message]).to eq('OK')
      end
    end

    it 'should return error with invalid email params' do
      post users_path, params: invalid_email_params.to_json, headers: api_headers
      expect(response).to have_http_status(:unprocessable_entity)
      expect(User.count).to eq 0
      expect(response_body[:message]).to eq('Email is invalid')
    end

    it 'should return error with empty email params' do
      post users_path, params: empty_email_params.to_json, headers: api_headers
      expect(response).to have_http_status(:unprocessable_entity)
      expect(User.count).to eq 0
      expect(response_body[:message]).to eq('Email can\'t be blank')
    end

    it 'should return error with mismatch password params' do
      post users_path, params: mismatch_password_params.to_json, headers: api_headers
      expect(response).to have_http_status(:unprocessable_entity)
      expect(User.count).to eq 0
      expect(response_body[:message]).to eq('Password confirmation doesn\'t match Password')
    end

    it 'should return error with empty password params' do
      post users_path, params: empty_password_params.to_json, headers: api_headers
      expect(response).to have_http_status(:unprocessable_entity)
      expect(User.count).to eq 0
      expect(response_body[:message]).to eq('Password can\'t be blank')
    end

    it 'should return error with same email id' do
      user.save
      post users_path, params: user_params.to_json, headers: api_headers
      expect(response).to have_http_status(:unprocessable_entity)
      expect(User.count).to eq 1
      expect(response_body[:message]).to eq('Email has already been taken')
    end
  end
end
