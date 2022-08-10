# frozen_string_literal: true

class ApiVersionConstraint

  def initialize(version, default: false)
    @version = version
    @default = default
  end

  # check whether version is specified or is default
  def matches?(request)
    @default || request.headers['Accept'].include?(version_header)
  end

  private

  def version_header
    # check version from Accept headers;
    "application/vnd.q-and-a.#{@version}"
  end
end
