require 'rubygems'
require 'pry'
require_relative '../track'
require 'test/unit'

class TrackTest <  Test::Unit::TestCase
	def test_set_morning_session
		event1 = Event.add_event("test event 1 60min")
		event2 = Event.add_event("test event 1 60min")
		event3 = Event.add_event("test event 1 60min")
		event4 = Event.add_event("test event 1 60min")
		track = Track.new(1)
		track.set_morning_session([event1,event2,event3])
		assert_equal 3,track.morning_session.session_events.size
		
		assert_raises SessionException do
    	track.set_morning_session([event1,event2,event3,event4])
    end
		
	end
	def test_set_afternoon_session
		event1 = Event.add_event("test event 1 60min")
		event2 = Event.add_event("test event 1 60min")
		event3 = Event.add_event("test event 1 60min")
		event4 = Event.add_event("test event 1 45min")
		event5 = Event.add_event("test event 1 lightning")
		track = Track.new(1)
		track.set_afternoon_session([event1,event2,event3,event4])
		assert_equal 4,track.afternoon_session.session_events.size
		
		assert_raises SessionException do
    	track.set_afternoon_session([event1,event2,event3,event4,event5])
    end
		
	end
	def test_display_track
		event1 = Event.add_event("test event 1 60min")
		event2 = Event.add_event("test event 1 60min")
		event3 = Event.add_event("test event 1 60min")
		event4 = Event.add_event("test event 1 60min")
		event5 = Event.add_event("test event 1 60min")
		event6 = Event.add_event("test event 1 60min")
		event7 = Event.add_event("test event 1 45min")
		event8 = Event.add_event("test event 1 lightning")
		track = Track.new(1)
		track.set_morning_session([event1,event2,event3])
		track.set_afternoon_session([event4,event5,event6])
		expected_string = "Track No: 1 \n\n"+"Morning Session\n\n09:00AM test event 1 : 60\n"+"10:00AM test event 1 : 60\n11:00AM test event 1 : 60\n12:00PM Lunch \n\n"
		expected_string+="Afternoon Session\n\n01:00PM test event 1 : 60\n"+"02:00PM test event 1 : 60\n03:00PM test event 1 : 60\n04:00PM Networking Event \n"
		assert_equal expected_string,track.display_track		
	end
	def test_empty_track
		track = Track.new(1)
		event1 = Event.add_event("test event 1 60min")
		event2 = Event.add_event("test event 1 60min")
		track.set_morning_session([event1])
		track.set_afternoon_session([event2])
		track.empty_track
		assert_equal nil, track.morning_session
		assert_equal nil, track.afternoon_session
	end
end

