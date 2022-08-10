# frozen_string_literal: true

module Api
  module V1
    class AnswersController < ApplicationController
      before_action :authenticate_user!

      def index
        question = current_user.questions.find_by(id: params[:question_id])
        if question
          @data = { question_id: question.id, answers: question.answers.with_user_details, message: :OK }
          render_success
        else
          render_success
        end
      end

      def create
      end

      def update
      end

      def destroy
      end
    end
  end
end