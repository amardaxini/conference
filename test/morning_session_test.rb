require 'rubygems'
require 'pry'
require_relative '../morning_session'
require 'test/unit'
class MorningSessionTest <  Test::Unit::TestCase
	def test_is_valid_events
		event1 = Event.add_event("test event 1 60min")
		event2 = Event.add_event("test event 2 60min")
		event3 = Event.add_event("test event 3 60min")
		event4 = Event.add_event("test event 4 40min")
		assert_equal true ,MorningSession.is_valid_session_events?([event1,event2])
		assert_equal true ,MorningSession.is_valid_session_events?([event1,event2,event3])
		assert_equal false ,MorningSession.is_valid_session_events?([event1,event2,event3,event4])
	end

	def test_add_session_events
		event1 = Event.add_event("test event 1 60min")
		event2 = Event.add_event("test event 2 60min")
		event3 = Event.add_event("test event 3 60min")
		event4 = Event.add_event("test event 4 40min")
		assert_equal 0,MorningSession.add_session_events([]).session_events.size
		assert_equal 3,MorningSession.add_session_events([event1,event2,event3]).session_events.size
		assert_equal 180,MorningSession.add_session_events([event1,event2,event3]).total_duration
		assert_raises SessionException do
    	MorningSession.add_session_events([event1,event2,event3,event4])
    end
	end
	def test_add_session_event
		event1 = Event.add_event("test event 1 60min")
		event2 = Event.add_event("test event 2 60min")
		event3 = Event.add_event("test event 3 60min")
		event4 = Event.add_event("test event 4 40min")
		session=MorningSession.add_session_events([event1,event2])
		session.add_session_event(event4)
		assert_equal 3,session.session_events.size
		assert_raises SessionException do
    	session.add_session_event(event3)
    end

	end

	def test_display_session
		event1 = Event.add_event("test event 1 60min")
		event2 = Event.add_event("test event 2 60min")
		event3 = Event.add_event("test event 3 60min")
		event4 = Event.add_event("test event 4 40min")
		session = MorningSession.add_session_events([event1,event2,event3])
		assert_equal "Morning Session\n\n09:00AM test event 1 : 60\n"+"10:00AM test event 2 : 60\n11:00AM test event 3 : 60\n12:00PM Lunch \n",session.display_session
		session = MorningSession.add_session_events([event1,event2,event3])
		assert_equal "Morning Session\n\n09:00AM test event 1 : 60\n"+"10:00AM test event 2 : 60\n11:00AM test event 3 : 60\n12:00PM Lunch \n",session.display_session
	end
end