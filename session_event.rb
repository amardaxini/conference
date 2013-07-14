require 'rubygems'
require 'pry'
require './event'
class SessionEvent 
  attr_accessor :start_time,:end_time,:event
  
  def initialize(event,start_time)
    @start_time  = start_time
    @event= event
    #@end_time = start_time + @event.duration
  end
  
end
