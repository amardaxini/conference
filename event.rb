
class Event
  attr_accessor :name ,:duration
  
  def initialize(name,duration)
    @name = name
    @duration = duration
  end


  
  class << self
  
    def is_parse_event_correct?(name)
      name.match(/\d*min$|lightning$/).nil? ? false : true
    end
    
    def add_parse_event(name)
      if is_parse_event_correct?(name)
        event_name = name.split(" ")
        duration = event_name.pop
       
        if duration.match(/\d*min$/)
          duration = duration.gsub(/min/,'').to_i
        else
          duration =  5
        end
        Event.new(event_name.join(" "),duration)
      else
      # Raise error invalid event
      end
    end
  end

end
