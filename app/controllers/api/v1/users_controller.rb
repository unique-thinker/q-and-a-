# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :find_user, only: %i[login]

      def create
        user = User.new(create_user_params)
        if user.save
          render_created('OK')
        else
          render_unprocessable_entity(user.errors.full_messages[0])
        end
      end

      def login
        if @user&.authenticate(login_params[:password])
          token = JsonWebToken.encode(payload: @user.slice(:id))
          @data = { message: :OK, token:, expire_at: 24.hours.from_now }
          render_success
        else
          render_unauthorized('Could not confirm credentials')
        end
      end

      private

      def create_user_params
        params.permit(:email, :password, :password_confirmation)
      end

      def login_params
        params.permit(:email, :password)
      end

      def find_user
        @user = User.find_by(email: login_params[:email])
      end
    end
  end
end
