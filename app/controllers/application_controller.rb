# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ApiResponseStatus
  attr_reader :current_user

  def auth_header
    request.headers['Authorization']
  end

  def authenticate_user!
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        u = JsonWebToken.decode(token)
        @current_user = User.find_by(id: u['id'])
      rescue JWT::DecodeError
        render_unauthorized
      end
    end
  end
end
