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

# conference.display_events
# conference.schedule_events
# puts conference.total_conference_time
  conference_1 = Conference.new
  conference_1.add_event("Test event 1 22min")
  conference_1.add_event("Test event 2 40min")
  conference_1.add_event("Test event 3 20min")
  conference_1.add_event("Test event 4 60min")
  conference_1.add_event("Test event 5 45min")
  conference_1.add_event("Test event 6 50min")
  conference_1.add_event("Test event 7 20min")
  conference_1.add_event("Test event 8 20min")
  conference_1.add_event("Test event 9 22min")
  conference_1.add_event("Test event 10 22min")
  conference_1.add_event("Test event 11 119min")
  conference_1.add_event("Test event 12 11min")
  conference_1.add_event("Test event 13 70min")
  conference_1.add_event("Test event 14 45min")
  conference_1.add_event("Test event 15 35min")
  conference_1.add_event("Test event 16 89min")

  # conference_1.display_events

  # conference_1.schedule_events
  
  # puts conference_1.total_conference_time
  # afternoon_events = []
  # morning_events =[]
  # conference_1.tracks.each {|x|x.morning_session.session_events.collect{|x| morning_events.push(x.event)}}
  # conference_1.tracks.each {|x|x.afternoon_session.session_events.collect{|x| afternoon_events.push(x.event)} rescue []}
  # puts conference_1.events - morning_events.flatten - afternoon_events.flatten
  # binding.pry
conference2 = Conference.new

conference2.add_event("Test event 1 60min")
conference2.add_event("Test event 2 40min")
conference2.add_event("Test event 3 20min")
conference2.add_event("Test event 4 60min")
conference2.add_event("Test event 5 45min")
conference2.add_event("Test event 6 40min")
# conference2.display_events
# conference2.schedule_events
conference3 = Conference.new

conference3.add_event("Test event 1 23min")
conference3.add_event("Test event 2 30min")
conference3.add_event("Test event 3 20min")
conference3.add_event("Test event 4 25min")
conference3.add_event("Test event 5 35min")
conference3.add_event("Test event 6 85min")
conference3.add_event("Test event 7 73min")
conference3.add_event("Test event 8 13min")
conference3.add_event("Test event 9 31min")
conference3.add_event("Test event 10 19min")
conference3.add_event("Test event 11 175min")
conference3.add_event("Test event 12 90min")
conference3.add_event("Test event 13 110min")
# conference3.display_events
conference3.schedule_events
conference3.display_tracks