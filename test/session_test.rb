require 'rubygems'
require 'pry'
require_relative '../session'
require 'test/unit'

class SessionTest <  Test::Unit::TestCase

	def test_session_initialize
		session = Session.new
		assert_equal [] ,session.session_events 
	end

	def test_set_session_events_size
		event = Event.add_event("test event 1 60min")
		event1 = Event.add_event("test event 2 30min")
		event2 = Event.add_event("test event 3 30min")
		event3 = Event.add_event("test event 4 60min")
		session = Session.add_session_events([event,event1,event2,event3])
		assert_equal 4,session.session_events.size 
		
		assert_equal event,session.session_events[0].event
		assert_equal event1,session.session_events[1].event
		assert_equal event2,session.session_events[2].event
		assert_equal event3,session.session_events[3].event

		assert_equal 540,session.session_events[0].start_time
		assert_equal 600,session.session_events[1].start_time
		assert_equal 630,session.session_events[2].start_time
		assert_equal 660,session.session_events[3].start_time
		
	end

	def test_display_events
		event1 = Event.add_event("test event 1 60min")
		event2 = Event.add_event("test event 2 30min")
		session = Session.add_session_events([event1,event2])
		assert_equal "09:00AM test event 1 : 60\n"+"10:00AM test event 2 : 30\n", session.display_events
	end

	def test_total_duration
		event1 = Event.add_event("test event 1 60min")
		event2 = Event.add_event("test event 2 30min")
		session = Session.add_session_events([event1,event2])
		assert_equal 90,session.total_duration
		session = Session.add_session_events([])
		assert_equal 0,session.total_duration
	end

	def test_add_session_event
		event1 = Event.add_event("test event 1 60min")
		event2 = Event.add_event("test event 2 30min")
		session = Session.add_session_events([event1])
		session.add_session_event(event2)
		assert_equal 90,session.total_duration
		assert_equal 2,session.session_events.size
	end

end