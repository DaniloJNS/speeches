# frozen_string_literal: true

module Api
  module V1
    # comments here
    class SpeechesController < ActionController::API
      def index
        @conference = Conference.all
        render json: format_json(@conference)
      end

      def create
        @response = ImportService.call params[:file]
        if @response
          render status: :created, json: format_json(@response)
        else
          render status: :unprocessable_entity
        end
      end

      private

      def format_json(object)
        object.as_json(only: [], include: { tracks: { only: %i[title],
                                                      include: {
                                                        sections: { only: %i[type_section],
                                                                    include: {
                                                                      speeches: { only: %i[time title
                                                                                           duration] }
                                                                    } }
                                                      } } })
      end
    end
  end
end
