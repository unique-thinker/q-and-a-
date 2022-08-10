# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.new(create_user_params)
        if user.save
          render_created('OK')
        else
          render_unprocessable_entity(user.errors.full_messages[0])
        end
      end

      private

      def create_user_params
        params.permit(:email, :password, :password_confirmation)
      end
    end
  end
end
