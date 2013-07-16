require 'rubygems'
require 'pry'
require_relative '../afternoon_session'
require 'test/unit'
class AfternoonSessionTest <  Test::Unit::TestCase
	def test_is_valid_events
		event1 = Event.add_event("test event 1 60min")
		event2 = Event.add_event("test event 2 60min")
		event3 = Event.add_event("test event 3 60min")
		event4 = Event.add_event("test event 4 40min")
		event5 = Event.add_event("test event 5 lightning")
		event6 = Event.add_event("test event 6 lightning")
		assert_equal true ,AfternoonSession.is_valid_session_events?([event1,event2,event3])
		assert_equal true ,AfternoonSession.is_valid_session_events?([event1,event2,event3,event4,event5])
		assert_equal false ,AfternoonSession.is_valid_session_events?([event1,event2,event3,event4,event5,event6])
	end

	def test_add_session_events
		event1 = Event.add_event("test event 1 60min")
		event2 = Event.add_event("test event 2 60min")
		event3 = Event.add_event("test event 3 60min")
		event4 = Event.add_event("test event 4 40min")
		event5 = Event.add_event("test event 5 lightning")
		event6 = Event.add_event("test event 6 lightning")
	
		assert_equal 0,AfternoonSession.add_session_events([]).session_events.size
		assert_equal 3,AfternoonSession.add_session_events([event1,event2,event3]).session_events.size
		assert_equal 180,AfternoonSession.add_session_events([event1,event2,event3]).total_duration
		assert_raises SessionException do
      AfternoonSession.add_session_events([event1,event2,event3,event4,event5,event6])
    end
	end
	def test_display_seesion
		event1 = Event.add_event("test event 1 60min")
		event2 = Event.add_event("test event 2 60min")
		event3 = Event.add_event("test event 3 60min")
		event4 = Event.add_event("test event 4 40min")
		session = AfternoonSession.add_session_events([event1,event2,event3])
		assert_equal "Afternoon Session\n\n01:00PM test event 1 : 60\n"+"02:00PM test event 2 : 60\n03:00PM test event 3 : 60\n04:00PM Networking Event \n",session.display_session
		session.add_session_event(event4)
		assert_equal "Afternoon Session\n\n01:00PM test event 1 : 60\n"+"02:00PM test event 2 : 60\n03:00PM test event 3 : 60\n04:00PM test event 4 : 40\n04:40PM Networking Event \n",session.display_session
	end
end