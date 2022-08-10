# frozen_string_literal: true

module ApiResponseStatus
  extend ActiveSupport::Concern

  # Success
  def render_success(data = @data, status = :ok)
    render json: { status: true }.merge!(response_format(data)), status: status and return
  end

  def render_created(data = @data)
    render json: { status: true }.merge!(response_format(data)), status: :created and return
  end

  def render_no_content
    render json: {}, status: :no_content
  end

  # Client Error
  def render_bad_request(message = @message)
    render json: {
      status: false,
      message: message || ''
    }, status: :bad_request and return
  end

  def render_unauthorized(message = @message)
    render json: {
      status: false,
      message: message || 'Unauthorized access!'
    }, status: :unauthorized and return
  end

  def render_forbidden(message = @message)
    render json: {
      status: false,
      message: message || 'You don\'t have permission for this'
    }, status: :forbidden and return
  end

  def render_not_found(message = @message)
    render json: {
      status: false,
      message: message || ''
    }, status: :not_found and return
  end

  def render_conflict(message = @message)
    render json: {
      status: false,
      message: message || ''
    }, status: :conflict and return
  end

  def render_unprocessable_entity(message = @message)
    render json: { status: false, message: }, status: :unprocessable_entity and return
  end

  def render_error(status, message = @message)
    render json: { status: false, message: message || {} }, status: status and return
  end

  private

  def response_format(data)
    case data
    when String
      { message: data.to_s }
    else
      { data: data || {} }
    end
  end
end
