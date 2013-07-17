require 'rubygems'
require 'pry'
require_relative './event'
class EventSchedular
	attr_accessor :events,:event_duration_matrix,:event_keep_matrix,:event_matrix
	def initialize
		@events = []
	end

	def total_events
		@events.size
	end

	def add_event(event)
		if event.is_a?(Event)	
			@events.push(event)
		else
			raise EventException.new("Not a valid event")
		end
	end

	def add_events(events)
		if events.is_a?(Array)
			events.each do |event|
				add_event(event)
			end
		elsif events.is_a?(Event)	
			add_event(event)
		else	
			raise EventException.new("Not a valid events")
		end
	end
	
	def schedule_events
		set_event_schedular_matrix
	end

	def set_event_schedular_matrix(max_duration=225)
    durations = @events.collect(&:duration)
    
    duration_significance = durations.each {|x|x/durations.size }
    @event_duration_matrix = [].tap { |m| (total_events+1).times { m << Array.new(max_duration+1) } }
    @event_duration_matrix[0].each_with_index { |value, index| @event_duration_matrix[0][index] = 0 }
    @event_keep_matrix = [].tap { |m| (total_events+1).times { m << Array.new(max_duration+1) } }
    @event_keep_matrix[0].each_with_index { |value, index| @event_keep_matrix[0][index] = 0 }
    set_schedular(durations,duration_significance,max_duration)
    @event_matrix = @event_keep_matrix
  end
  
  # Knapsack
  def set_schedular(durations,duration_significance,max_duration)
    (1..total_events).each do |i|
      significance_value, = duration_significance[i-1]
      duration=  durations[i-1]
      (0..max_duration).each do |x|
      
        if duration > x
          @event_duration_matrix[i][x] = @event_duration_matrix[i-1][x]
          @event_keep_matrix[i][x] = 0
        else
          @event_duration_matrix[i][x] = [@event_duration_matrix [i-1][x],
           @event_duration_matrix[i-1][x-duration] + significance_value].max
           
          if((@event_duration_matrix[i-1][x-duration] + significance_value) < @event_duration_matrix[i-1][x])
            @event_keep_matrix[i][x] = 0
          else
            @event_keep_matrix[i][x] = 1
          end
        end
      end
    end
  end
    # From event matrix it will fetch duration and set 0 
  # so same event can't be repeated
  # It will start from last event and check for duration
  # Suppose Searching for 180 total event is 20
  # Last event is wworth of 30 min now
  # next event will be 19 and it will try to search on 180-30=150 
  # if it's 1 then add it other wise go to next event i.e 18
  def get_events_for_duration(duration)
    events = []
   
    total_events.downto(0).each do |i|
      if(@event_matrix[i][duration] == 1)
        event = @events[i-1]
        @event_matrix[i].each_with_index { |value, index| @event_matrix[i][index] = 0 }
        duration = duration - event.duration
        events << event
      end
    end  
    
    events
  end
end