require 'rubygems'
require 'pry'
require_relative './session_event'
class Session
  attr_accessor :session_events
  def initialize
    @session_events = []
  end
  
  
  def display_events
    events_string = ""
    @session_events.each do |session_event|
      events_string << session_event.display_session_event+"\n"
    end
    events_string
  end
  
  def total_duration
    @session_events.inject(0) {|sum,x| sum+x.event.duration}
  end

  def add_session_event(event)
    if self.session_events.empty?
      start_time = 540
    else
      start_time = self.session_events.last.end_time
    end
    @session_events << SessionEvent.new(event,start_time)
  end

  def self.add_session_events(events,start_time=540)
    @session = self.new   
    events.each_with_index do |event,index|
      @session.add_session_event(event)
    end  
    @session
  end

  def self.class_name
    "Session"
  end

end
