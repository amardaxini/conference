require 'rubygems'
require 'pry'
require_relative '../session_event'
require 'test/unit'
class SessionEventTest <  Test::Unit::TestCase

	def setup
		event = Event.add_event("test event 30min")
		@session_event = SessionEvent.new(event,540)
	end
	
	def test_end_time
		assert_equal 570,@session_event.end_time
	end

	def test_display_start_time
		assert_equal "09:00AM",@session_event.display_start_time
		assert_equal "09:30AM",@session_event.display_end_time
	end

	def test_display_event
		assert_equal "09:00AM test event : 30",@session_event.display_session_event	
	end
end