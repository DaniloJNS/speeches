class SaveSpeechInDiskWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform file
    path = 'public/uploads/'
    file = "dados_#{Time.now.to_i}.txt"
    path = File.join(Rails.root, path, file)

    File.open(path, 'wb') do |f|
      f.write(file.read)
    end

    file
  end
end
