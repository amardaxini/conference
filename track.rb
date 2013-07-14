require 'rubygems'
require 'pry'
require './session'
class Track
  attr_accessor :track_no,:morning_session,:afternoon_session

  def initialize(track_no)
    @track_no = track_no
    
  end
  
  def set_morning_session(events)
    @morning_session = Session.set_session_events(events)
  end
  
  def set_afternoon_session(events)
    @afternoon_session = Session.set_session_events(events,780)
  end
  
end
