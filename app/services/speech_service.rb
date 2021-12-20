class SpeechService < ApplicationService
  MORNING_INITIAL_TIME = 540
  EVENING_INITIAL_TIME = 780
  MORNING_MAX_TIME = 180
  EVENING_MAX_TIME = 240

  def initialize(speeches)
    @speeches = speeches
    @conference = Conference.create
  end

  def call
    save
    @conference
  end
def save
    factory_sections @speeches, tracks: factory_tracks(@speeches)
  end

  protected

  def total_duration objs
    sum  = 0
    objs.each do |obj|
      sum += obj[:duration].to_i
    end
    sum
  end

  def tracks_count conference_duration
    return conference_duration / 360 if conference_duration % 360 < 60 * conference_duration / 360
    conference_duration / 360 + 1
  end

  def find_speech objs, max
    index = objs.index { |obj| obj[:duration].to_i <= max && obj[:duration].to_i > 5 }
    
    return index unless index.nil?

    objs.index { |obj| obj[:duration].to_i <= max }
  end

  def speech_morning objs, max: MORNING_MAX_TIME, res: []
    res << objs.delete_at(find_speech(objs, max))
    max -= res.last[:duration].to_i
    if max > 0
      speech_morning(objs, max: max, res: res) 
    elsif max.eql? 0
      [res, objs]
    else
      nil
    end
  end

  def speech_evening objs, max: EVENING_MAX_TIME, res: []
    res << objs.delete_at(find_speech(objs, max))
    max -= res.last[:duration].to_i
    if max > 60 || (objs.any? && max > 0)
      speech_evening(objs, max: max, res: res) 
    elsif max >= 0
      [res, objs]
    else
      nil
    end
  end

  def factory_tracks objs 
    tracks = [] 
    tracks_count(total_duration(objs)).times.with_index do |i|
      tracks << Track.create(title: "Track #{UtilityService.convert_alphabet(i)}", conference: @conference)
    end
    tracks
  end

  def factory_sections speeches, tracks:, morning: true 
    tracks.each do |track|
     speeches = morning ? speech_morning(speeches) : speech_evening(speeches) 
     time = morning ? MORNING_INITIAL_TIME : EVENING_INITIAL_TIME
     section = morning ? Section.create(type_section: "morning", track: track) : Section.create(type_section: "evening", track: track)
     factory_speech(speeches.first, section: section, time: time)
     speeches = speeches.second
    end
    factory_sections speeches, tracks: tracks, morning: false if morning
  end

  def factory_speech objs, section:, time: 
    objs.each do |obj|
      time += Speech.create(title: obj[:title], duration: obj[:duration], time: time, 
                            section: section).duration
    end
    Speech.create(title: "Evento de Networking", duration: 0, time: 1020, section: section) if section.evening?
  end
end
