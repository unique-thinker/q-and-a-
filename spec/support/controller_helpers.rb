# frozen_string_literal: true

module ControllerHelpers
  def login(user)
    post '/api/login', params:  {
      email:    user.email,
      password: user.password
    }.to_json, headers: api_headers
  end
end
