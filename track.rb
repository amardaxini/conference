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
  
  def print_track
    puts "Track No: #{@track_no} \n\n"
    puts "Morning Session \n \n"
    @morning_session.display_events
    
    if @afternoon_session
        puts  "\n"  
       puts "Afternoon Session \n \n"
       @afternoon_session.display_events
    end
    
  end
  

end
