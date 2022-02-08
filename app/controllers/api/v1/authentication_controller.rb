module Api
  module V1
    class AuthenticationController < ApplicationController
      before_action :password_params, only: %i[create]
      def create
        raise Unauthorized unless user&.authenticate(@password)

        token = AuthenticationTokenService.call(user.id)
        render json: { token: token }, status: :created
      end

      private

      def user
        @user ||= User.find_by(user_name: params.require(:user_name))
      end

      def password_params
        @password = params.require(:password)
      end
    end
  end
end
