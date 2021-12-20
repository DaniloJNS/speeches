# speeches = []

# open("#{Rails.root}/spec/fixtures/files/case.txt") do |file|
#   file.each_with_index do |linha, _i|
#     speeches << { title: linha.split(/\w+$/).first, duration: linha.slice(/\d+/) || 5  }
#   end
# end

# conference = SpeechService.call speeches

# path = "spec/support/api/case.json"

# File.open(path, "wb") do |f|
#   f.write(conference.as_json(only: [], include: { tracks: { only: %i[title],
#                                                       include: {
#                                                         sections: { only: %i[type_section],
#                                                                     include: {
#                                                                       speeches: { only: %i[time title
#                                                                                            duration] }
#                                                                     } }
#                                                       } } }).to_json)
# end
