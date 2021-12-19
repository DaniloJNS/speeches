# frozen_string_literal: true

class ImportService < ApplicationService
  def initialize(file)
    @file = file
  end

  def call
    return false unless validateExtension

    file_name = save_in_disk
    response = save_in_db file_name
  end

  def save_in_disk
    path = 'public/uploads/'
    file = "dados_#{Time.now.to_i}.txt"
    path = File.join(Rails.root, path, file)

    File.open(path, 'wb') do |f|
      f.write(@file.read)
    end

    file
  end

  def save_in_db(file)
    SpeechService.call to_hash(file)
  end

  def validateExtension
    allow_extensions = ['.txt']
    return false if @file.nil?

    allow_extensions.include? File.extname(@file.original_filename)
  end

  def to_hash(file)
    speeches = []

    open("#{Rails.root}/public/uploads/#{file}") do |file|
      file.each_with_index do |linha, _i|
        speeches << { title: linha.split(/\w+$/).first, duration: linha.slice(/\d+/) || 5  } 
      end
    end

    speeches
  end
end
