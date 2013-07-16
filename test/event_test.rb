require 'rubygems'
require 'pry'
require_relative '../event'
require 'test/unit'

class EventTest <  Test::Unit::TestCase

	def test_invalid_add_event
		name = "test event"
		assert_raises EventException do
      Event.add_event(name)
    end
    name = "test event 1hr"

    assert_raises EventException do
      Event.add_event(name)
    end
	end

	def test_valid_add_event
		name = "test event 30min"
		event = Event.add_event(name)
		assert_equal "test event",event.name
		assert_equal 30,event.duration
	end

	def test_valid_add_event_for_lightning
		name = "test event lightning"
		event = Event.add_event(name)
		assert_equal "test event",event.name
		assert_equal 5,event.duration
	end

	def test_is_validity_of_event
		name = "test event 30min"
		assert_equal true,Event.is_valid?(name)
		name = "test event 1hr"
		assert_equal false,Event.is_valid?(name)
		name = "test event lightning"
		assert_equal true,Event.is_valid?(name)
	end

end