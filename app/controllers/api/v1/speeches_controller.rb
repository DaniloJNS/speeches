# frozen_string_literal: true

module Api
  module V1
    # comments here
    class SpeechesController < ActionController::API
      def index
        @conference = Conference.all
        render json: @conference.as_json(only: [], include: { tracks: { only: %i[title],
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
