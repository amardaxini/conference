require 'rubygems'
require 'pry'
require_relative '../event_schedular'
require_relative '../event'
require 'test/unit'
class EventSchedularTest <  Test::Unit::TestCase

	def test_add_event
		event_schedular = EventSchedular.new
		event1 = Event.add_event("Test event 1 10min")
		event2 = Event.add_event("Test event 2 12min")
		event3 = Event.add_event("Test event 3 3min")
		event4 = Event.add_event("Test event 4 4min")
		event5 = Event.add_event("Test event 5 5min")
		event_schedular.add_event(event1)
		assert_equal 1, event_schedular.total_events
		event_schedular.add_events([event2,event3,event4,event5])
		assert_equal 5, event_schedular.total_events
		assert_raises EventException do
      event_schedular.add_event("Some random text")
    end
	end

	def test_scheduling_events
		event1 = Event.add_event("Test event 1 1min")
		event2 = Event.add_event("Test event 2 2min")
		event3 = Event.add_event("Test event 3 3min")
		event4 = Event.add_event("Test event 4 4min")
		event5 = Event.add_event("Test event 5 5min")
		event6 = Event.add_event("Test event 6 1min")
		event_schedular = EventSchedular.new
		event_schedular.add_events([event1,event2,event3,event4,event5])
		event_schedular.set_event_schedular_matrix(5)
		assert_equal [event5],event_schedular.get_events_for_duration(5)

		event_schedular = EventSchedular.new
		event_schedular.add_events([event1,event2,event5,event4,event3])
		event_schedular.set_event_schedular_matrix(5)
		assert_equal [event3,event2],event_schedular.get_events_for_duration(5)

		event_schedular = EventSchedular.new
		event_schedular.add_events([event1,event2,event5,event4,event3])
		event_schedular.set_event_schedular_matrix(10)
		assert_equal [event3,event4,event2,event1],event_schedular.get_events_for_duration(10)

		event_schedular = EventSchedular.new
		event_schedular.add_events([event1,event2,event4,event3,event5])
		event_schedular.set_event_schedular_matrix(15)
		assert_equal [event5,event3,event2],event_schedular.get_events_for_duration(10)
		event_schedular = EventSchedular.new
		
		event_schedular.add_events([event1,event4,event6])
		event_schedular.set_event_schedular_matrix(10)
		assert_equal [event6,event1] ,event_schedular.get_events_for_duration(3)

	end
end