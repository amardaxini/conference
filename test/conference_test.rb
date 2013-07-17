require 'rubygems'
require 'pry'
require_relative '../conference'
require 'test/unit'
class ConferenceTest  <  Test::Unit::TestCase

	def setup
		@conference = Conference.new
		@conference.add_event("Test event 1 60min")
		@conference.add_event("Test event 2 40min")
		@conference.add_event("Test event 3 20min")
		@conference.add_event("Test event 4 60min")
		@conference.add_event("Test event 5 45min")
		@conference.add_event("Test event 6 40min")
	end

	def test_add_event
		name = "Test Event 1 20min"
		conference = Conference.new
		conference.add_event(name)
		assert_equal 1,conference.events.size
		assert_equal "Test Event 1",conference.events.last.name
		assert_equal 20,conference.events.last.duration

    assert_raises EventException do
      conference.add_event("Test Event 2 1hr")
    end
	end

	def test_total_event
		assert_equal 6,@conference.total_events
	end

	def test_total_confernce_time
		@conference.set_total_confernce_time
		assert_equal 265,@conference.total_conference_time
	end

	def test_conference_parameter
		
		@conference.set_conference_parameter
		assert_equal @conference.total_session,2
		assert_equal @conference.total_track_day,1
		@conference.add_event("Test event 5 60min")
		@conference.add_event("Test event 6 60min")
		@conference.add_event("Test event 7 60min")
		@conference.set_conference_parameter
		assert_equal @conference.total_session,2
		assert_equal @conference.total_track_day,1
		@conference.add_event("Test event 8 20min")
		@conference.set_conference_parameter
		assert_equal @conference.total_session,3
		assert_equal @conference.total_track_day,2
	end

	def test_set_tracks
		@conference.set_conference_parameter
		@conference.set_tracks
		assert_equal 1,@conference.tracks.size
		assert_equal 1,@conference.tracks[0].track_no
	end

	def test_schedular_matrix
			
	end

end