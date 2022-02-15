json.array! @conference do |conference|
  json.tracks conference.tracks do |track| 
    json.title track.title
    json.sections track.sections do |section|
      json.type_section section.type_section
      json.speeches section.speeches do |speech|
        json.time speech.time
        json.title speech.title
        json.duration speech.duration
      end
    end
  end
end
