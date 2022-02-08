# frozen_string_literal: true

class ApplicationController < ActionController::API
  class Unauthorized < StandardError; end
  include ActionController::HttpAuthentication::Token

  rescue_from ActionController::ParameterMissing, with: :paremeter_missing
  rescue_from Unauthorized, with: :handle_unauthorized

  private

  def authentication
    token, _options = token_and_options(request)
    user_id = AuthenticationTokenService.decode token
    User.find(user_id[:user_id])
  rescue StandardError
    render status: :unauthorized
    # TODO: Usar uma class apropiada para lidar com error
  end

  def paremeter_missing(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end

  def handle_unauthorized
    head :unauthorized
  end
end
