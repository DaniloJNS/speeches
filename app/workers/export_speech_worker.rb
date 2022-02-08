class ExportSpeechWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform conference_id
    write_file Conference.find(conference_id)
  end
  
  def write_file conference
    path = 'public/exports/'
    file = "dados_#{Time.now.to_i}.txt"
    path = File.join(Rails.root, path, file)

    File.open(path, 'wb') do |file|
      write_tracks conference.tracks, file
    end

    conference.update(file_name: file)

    path
  end

  def write_speeches speeches, file
    speeches.each do |speech|
      file.write "\t\t#{speech.time} #{speech.title} #{speech.duration}\n"
    end
  end

  def write_sections sections, file
    sections.each do |speech|
      file.write("\t#{speech.type_section}\n")
      write_speeches speech.speeches, file
    end
  end

  def write_tracks tracks, file
    tracks.each do |track|
      file.write("#{track.title}\n")
      write_sections track.sections, file
    end
  end
end
