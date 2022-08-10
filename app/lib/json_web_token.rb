# frozen_string_literal: true

class JsonWebToken
  class << self
    def encode(payload:, exp: 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode payload, rsa_private, 'RS256'
    end

    def decode(token)
      decoded = JWT.decode(token, rsa_public, true, { algorithm: 'RS256' })[0]
      HashWithIndifferentAccess.new decoded
    end

    private

    def rsa_private
      OpenSSL::PKey::RSA.new(
        File.read(Rails.application.credentials.config[:jwt][:private_key_path])
      )
    end

    def rsa_public
      OpenSSL::PKey::RSA.new(
        File.read(Rails.application.credentials.config[:jwt][:public_key_path])
      )
    end
  end
end
