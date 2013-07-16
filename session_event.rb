require 'rubygems'
require 'pry'
require_relative './event'
require_relative './time_formatter'
class SessionEvent 
  attr_accessor :start_time,:end_time,:event
  
  def initialize(event,start_time)
    @start_time  = start_time
    @event= event
    @end_time = start_time + @event.duration
  end
  
  def display_start_time
    TimeFormatter.format_time(self.start_time).to_s
  end

  def display_end_time
  	TimeFormatter.format_time(self.start_time+event.duration).to_s
  end

  def display_session_event
    "#{display_start_time} #{event.name} : #{event.duration.to_s}"
  end
  
end
