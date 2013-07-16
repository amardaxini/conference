require 'rubygems'
require 'pry'
module SessionHelper
	module ClassMethods
		def is_valid_session_events?(events)
  		events.inject(0){|sum,x|sum+x.duration} <= self::END_TIME - self::START_TIME
  	end

  	def add_session_events(events)
  		if is_valid_session_events?(events)	
  			super(events)
  		else
  			raise SessionException.new("#{self.class_name} events duration is more than expected")	
  		end
  	end
	end
	
	module InstanceMethods
		def can_add_session_event?(event)
  		self.total_duration+event.duration <= self.class::END_TIME - self.class::START_TIME
  	end

		def add_session_event(event)
			if can_add_session_event?(event)
				start_time = total_duration+self.class::START_TIME
		  	@session_events << SessionEvent.new(event,start_time)
		  else
		  	raise SessionException.new("Can't add more event to session limit is reached")
		  end	
		end
	end
	
	def self.included(receiver)
		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods
	end
end