# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Answers', type: :request do
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let(:question_answers_path) { "/api/questions/#{question.id}/answers" }
  let(:question_answer_path) { "/api/questions/#{question.id}/answers/#{answer.id}" }
  let(:token) { JsonWebToken.encode(payload: user.slice(:id)) }
  let(:invalid_token) { Faker::Internet.device_token }

  describe '/api/questions/:question_id/answers' do
    let!(:answers) { create_list :answer, 3, user: user, question: question }

    context 'with valid credentials' do
      it 'should return success with answers list' do
        get question_answers_path, headers: api_headers(authorization: token)
        expect(response).to have_http_status(:ok)
        expect(response_body[:data][:question_id]).to eq question.id
        expect(response_body[:data][:answers].size).to eq answers.count
      end
    end

    context 'with invalid' do
      it 'should return error with message' do
        get question_answers_path, headers: api_headers(authorization: invalid_token)
        expect(response).to have_http_status(:unauthorized)
        expect(response_body[:message]).to eq 'Unauthorized access!'
      end

      it 'should return error with message' do
        get "/api/questions/#{99999}/answers", headers: api_headers(authorization: token)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
