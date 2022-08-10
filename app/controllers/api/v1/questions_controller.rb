# frozen_string_literal: true

module Api
  module V1
    class QuestionsController < ApplicationController
      before_action :authenticate_user!

      def index
        render_success(
          current_user.questions.with_user_details.as_json(except: :user_id)
        )
      end

      def create
        question = current_user.questions.build(create_question_params)
        if question.save
          @data = { message: :OK, question_id: question.id }
          render_created
        else
          data = { message: 'NOT_OK', error: question.errors.full_messages[0] }
          render json: { status: false, data: }, status: :unprocessable_entity
        end
      end

      def update
        question = current_user.questions.find_by(id: update_question_params[:id])
        if question&.update(body: update_question_params[:body])
          render_success('OK')
        else
          data = { message: 'NOT_OK', error: question.errors.full_messages[0] }
          render json: { status: false, data: }, status: :unprocessable_entity
        end
      end

      def destroy
        question = current_user.questions.find_by(id: params[:id])
        if question&.destroy
          render_success('OK')
        else
          data = { message: :'NOT_OK', error: :error }
          render json: { status: false, data: }, status: :unprocessable_entity
        end
      end

      private

      def create_question_params
        params.permit(:title, :body, :tags)
      end

      def update_question_params
        params.permit(:id, :body)
      end
    end
  end
end
