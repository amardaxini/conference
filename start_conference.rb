require './conference'
events = [
  "Writing Fast Tests Against Enterprise Rails 60min",
  "Overdoing it in Python 45min",
  "Lua for the Masses 30min",
  "Ruby Errors from Mismatched Gem Versions 45min",
  "Common Ruby Errors 45min",
  "Rails for Python Developers lightning",
  "Communicating Over Distance 60min",
  "Accounting-Driven Development 45min",
  "Woah 30min",
  "Sit Down and Write 30min",
  "Pair Programming vs Noise 45min",
  "Rails Magic 60min",
  "Ruby on Rails: Why We Should Move On 60min",
  "Clojure Ate Scala (on my project) 45min",
  "Programming in the Boondocks of Seattle 30min",
  "Ruby vs. Clojure for Back-End Development 30min",
  "Ruby on Rails Legacy App Maintenance 60min",
  "A World Without HackerNews 30min",
  "User Interface CSS in Rails Apps 30min",
]
conference = Conference.new  
events.each do |event|
  conference.add_event(event)
end  

conference.display_events
conference.schedule_events
puts conference.total_conference_time
  @conference = Conference.new
  @conference.add_event("Test event 1 22min")
  @conference.add_event("Test event 2 40min")
  @conference.add_event("Test event 3 20min")
  @conference.add_event("Test event 4 60min")
  @conference.add_event("Test event 5 45min")
  @conference.add_event("Test event 6 50min")
  @conference.add_event("Test event 7 20min")
  @conference.add_event("Test event 8 20min")
  @conference.add_event("Test event 9 22min")
  @conference.add_event("Test event 10 22min")
  @conference.add_event("Test event 11 119min")
  @conference.add_event("Test event 12 11min")
  @conference.add_event("Test event 13 70min")
  @conference.add_event("Test event 14 45min")
  @conference.add_event("Test event 15 35min")
  @conference.add_event("Test event 16 89min")

  # @conference.display_events

  # @conference.schedule_events
  
  # puts @conference.total_conference_time
  # afternoon_events = []
  # morning_events =[]
  # @conference.tracks.each {|x|x.morning_session.session_events.collect{|x| morning_events.push(x.event)}}
  # @conference.tracks.each {|x|x.afternoon_session.session_events.collect{|x| afternoon_events.push(x.event)} rescue []}
  # puts @conference.events - morning_events.flatten - afternoon_events.flatten
  # binding.pry
