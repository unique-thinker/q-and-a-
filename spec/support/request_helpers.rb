# frozen_string_literal: true

module RequestHelpers
  module Json
    # Parse JSON response to ruby hash
    def response_body
      @response_body ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  # Our headers helpers module
  module Headers
    def api_headers(version = 'v1')
      {
        'Content-Type': 'application/json; charset=utf-8',
        Accept: "application/vnd.q-and-a.#{version}"
      }
    end
  end
end
