# frozen_string_literal: true

module Api
  module V1
    # comments here
    class SpeechesController < ApplicationController
      before_action :authentication, only: %i[index create show]
      def index
        @conference = Conference.all
        render json: format_json(@conference)
      end

      def create
        @response = ImportService.call params[:file]
        if @response
          render :create, status: :created
        else
          render status: :unprocessable_entity
        end
      end

      def show
        @conference = Conference.find(params[:id])
        @response = ExportService.call @conference
        if @response.present?
          send_file @response
        else
          render status: :processing
        end
      end

      private

      def format_json(object)
        object.as_json(only: %i[], include: { tracks: { only: %i[title],
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
