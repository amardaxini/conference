require 'rubygems'
require 'pry'
require_relative './session'
require_relative './morning_session'
require_relative './afternoon_session'
class Track
  attr_accessor :track_no,:morning_session,:afternoon_session

  def initialize(track_no)
    @track_no = track_no
  end
  
  def set_morning_session(events)
    @morning_session = MorningSession.add_session_events(events)
  end
  
  def set_afternoon_session(events)
    @afternoon_session = AfternoonSession.add_session_events(events)
  end
  
  def display_track
    track_string =  "Track No: #{@track_no} \n\n"
    track_string+= @morning_session.display_session if @morning_session
    if @afternoon_session
      track_string+="\n"
      track_string+= @afternoon_session.display_session
    end
    track_string
  end

  def empty_track
    @morning_session = nil
    @afternoon_session = nil
  end
  def get_all_session_events

    [(@morning_session.session_events rescue nil),(@afternoon_session.session_events rescue nil)].flatten.compact.uniq
  end
end
