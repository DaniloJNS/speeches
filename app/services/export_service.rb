class ExportService < ApplicationService
  PATH = 'public/exports'.freeze

  def initialize(conference)
    super
    @conference = conference
  end

  def call
    if validate
      File.join(Rails.root, PATH, @conference.file_name)
    else
      ExportSpeechWorker.perform_async @conference.id
      nil
    end
  end

  def validate
    @conference.file_name_in_database.present?
  end
end
