module Api
  module V1
    class AuthenticationController < ApplicationController
      before_action :password_params, only: %i[create]
      around_action :user_loked, only: %i[create]

      def create
        unless user&.authenticate(@password)
          AuthenticationService.call user&.id if user.present?
          raise AuthenticationError
        end

        AuthenticationService.restart user.id
        token = AuthenticationTokenService.call(user.id)
        render json: { token: token }, status: :created
      end

      private

      def user_loked
        begin
          AuthenticationService.validate user&.id if user.present?
        rescue AuthenticationService::AttemptLimitsExceeded
          return head :locked
        end
        yield
      end

      def user
        @user ||= User.find_by(user_name: params.require(:user_name))
      end

      def password_params
        @password = params.require(:password)
      end
    end
  end
end
