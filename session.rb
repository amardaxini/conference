require 'rubygems'
require 'pry'
require './session_event'
class Session
  attr_accessor :session_events
  def initialize
    @session_events = []
  end
  
   def self.set_session_events(events,start_time=540)
    @session = Session.new   
    events.each_with_index do |event,index|

      @session.session_events << SessionEvent.new(event,start_time)
      start_time =  start_time+event.duration
    end  
    @session
  end
  
  def display_events
    @session_events.each do |session_event|

      puts session_event.display_start_time + " " + session_event.event.name + " : " + session_event.event.duration.to_s + "\n"
    end
  end
end
