require 'rubygems'
require 'pry'
require_relative "./conference_exception"
class Event
  attr_accessor :name ,:duration
  
  def initialize(name,duration)
    @name = name
    @duration = duration
  end
  
  class << self
  
    def is_valid?(name)
      name.match(/\d*min$|lightning$/).nil? ? false : true
    end
    
    def add_event(name)
      if is_valid?(name)
        event_name = name.split(" ")
        duration = event_name.pop
       
        if duration.match(/\d*min$/)
          duration = duration.gsub(/min/,'').to_i
        else
          duration =  5
        end
        Event.new(event_name.join(" "),duration)
      else
        raise EventException.new('Event should be @name @durationmin or @name lightning')
        
      end
    end
  end

end
