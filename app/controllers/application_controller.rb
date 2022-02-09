# frozen_string_literal: true

class ApplicationController < ActionController::API
  class AuthenticationError < StandardError; end
  include ActionController::HttpAuthentication::Token

  rescue_from ActionController::ParameterMissing, with: :paremeter_missing
  rescue_from AuthenticationError, with: :handle_unauthorized

  private

  def authentication
    token, _options = token_and_options(request)
    user_id = AuthenticationTokenService.decode token
    User.find(user_id[:user_id])
  rescue ActiveRecord::RecordNotFound
    render status: :unauthorized
  end

  def handle_limits_exceeded(user_id)
    AuthenticationService.call user_id
    render json: { error: 'Acesso bloqueado, contate o administrador' },
           status: :locked
  end

  def paremeter_missing(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end

  def handle_unauthorized
    head :unauthorized
  end
end
