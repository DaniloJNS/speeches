class AuthenticationTokenService < ApplicationService
  HMAC_SECRET = ENV.fetch('HMAC_SECRET') { 'my_secret' }
  ALGORITM_TYPE = 'HS256'.freeze

  def initialize(user_id)
    super
    @user_id = user_id
  end

  def call
    payload = { user_id: @user_id }

    JWT.encode payload, HMAC_SECRET, ALGORITM_TYPE
  end

  def self.decode(token)
    JWT.decode(token, HMAC_SECRET, true, { algorithm: ALGORITM_TYPE })
       .first.symbolize_keys
  rescue JWT::DecodeError
    { user_id: nil }
  end
end
