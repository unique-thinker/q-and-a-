# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  let!(:questions_path) { '/api/questions' }
  let(:question_path) { "/api/questions/#{question.id}" }
  let!(:user) { create(:user) }
  let!(:token) { JsonWebToken.encode(payload: user.slice(:id)) }
  let!(:invalid_token) { Faker::Internet.device_token }

  describe 'GET /api/questions' do
    let!(:questions) { create_list :question, 3, user: }

    context 'with valid credentials' do
      it 'should return success with question list' do
        get questions_path, headers: api_headers(authorization: token)
        expect(response).to have_http_status(:ok)
        expect(response_body[:data].size).to eq questions.size
      end
    end

    context 'with invalid credentials' do
      it 'should return error' do
        get questions_path, headers: api_headers(authorization: invalid_token)
        expect(response).to have_http_status(:unauthorized)
        expect(response_body[:message]).to eq 'Unauthorized access!'
      end
    end
  end

  describe 'POST /api/questions' do
    let(:question) { build(:question) }

    context 'with valid params' do
      it 'should return success with question id' do
        post questions_path, params: question.attributes.to_json,
        headers: api_headers(authorization: token)
        expect(response).to have_http_status(:created)
        expect(Question.count).to eq 1
        expect(response_body[:data][:message]).to eq 'OK'
        expect(response_body[:data][:question_id]).to eq Question.last.id
      end
    end

    context 'with invalid params' do
      it 'should return error with invalid token' do
        post questions_path, params: question.attributes.to_json,
        headers: api_headers(authorization: invalid_token)
        expect(response).to have_http_status(:unauthorized)
        expect(response_body[:message]).to eq 'Unauthorized access!'
      end

      it 'should return error with empty title' do
        post questions_path, params: question.attributes.merge('title' => nil).to_json,
        headers: api_headers(authorization: token)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body[:data][:message]).to eq 'NOT_OK'
        expect(response_body[:data][:error]).to eq 'Title can\'t be blank'
      end

      it 'should return error with empty body' do
        post questions_path, params: question.attributes.merge('body' => nil).to_json,
        headers: api_headers(authorization: token)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body[:data][:message]).to eq 'NOT_OK'
        expect(response_body[:data][:error]).to eq 'Body can\'t be blank'
      end
    end
  end

  describe 'PATCH /api/questions/:id' do
    let!(:question) { create(:question, user:) }
    let!(:update_params) { { body: Faker::Lorem.paragraph(sentence_count: 4) } }

    context 'with valid params' do
      it 'should return success with message' do
        patch question_path, params: update_params.to_json,
        headers: api_headers(authorization: token)
        expect(response).to have_http_status(:ok)
        expect(response_body[:message]).to eq 'OK'
      end
    end

    context 'with invalid params' do
      it 'should return error with invalid token' do
        patch question_path, params: update_params.to_json,
        headers: api_headers(authorization: invalid_token)
        expect(response).to have_http_status(:unauthorized)
        expect(response_body[:message]).to eq 'Unauthorized access!'
      end

      it 'should return error with empty body' do
        patch question_path, params: { body: nil }.to_json,
        headers: api_headers(authorization: token)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body[:data][:message]).to eq 'NOT_OK'
        expect(response_body[:data][:error]).to eq 'Body can\'t be blank'
      end
    end
  end

  describe 'DELETE /api/questions/:id' do
    let!(:question) { create(:question, user: user) }
    let(:question_1) { create(:question) }

    context 'with valid params' do
      it 'should return success with message' do
        delete question_path, headers: api_headers(authorization: token)
        expect(response).to have_http_status(:ok)
        expect(response_body[:message]).to eq 'OK'
        expect(Question.count).to eq 0
      end
    end

    context 'with invalid params' do
      it 'should return error with invalid token' do
        delete question_path, headers: api_headers(authorization: invalid_token)
        expect(response).to have_http_status(:unauthorized)
        expect(response_body[:message]).to eq 'Unauthorized access!'
      end

      it 'should return error with invalid id' do
        delete "/api/questions/#{question_1.id}", headers: api_headers(authorization: token)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body[:data][:message]).to eq 'NOT_OK'
        expect(response_body[:data][:error]).to eq 'error'
      end
    end
  end
end
