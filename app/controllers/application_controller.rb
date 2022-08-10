# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ApiResponseStatus

  def auth_header
    request.headers['Authorization']
  end
end
