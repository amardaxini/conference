require 'rubygems'
require 'pry'
require './event'
require './time_formatter'
class SessionEvent 
  attr_accessor :start_time,:end_time,:event
  
  def initialize(event,start_time)
    @start_time  = start_time
    @event= event
    #@end_time = start_time + @event.duration
  end
  
  def display_start_time
    TimeFormatter.format_time(self.start_time).to_s
  end
  
end
