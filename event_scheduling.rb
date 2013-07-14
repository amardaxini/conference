require 'rubygems'
require 'pry'
def get_events
events={
	"Writing Fast Tests Against Enterprise Rails"=> 60,
	"Overdoing it in Python"=> 45,
	"Lua for the Masses"=> 30,
	"Ruby Errors from Mismatched Gem Versions"=> 45,
	"Common Ruby Errors"=> 45,
	"Rails for Python Developers"=>5,
	"Communicating Over Distance"=> 60,
	"Accounting-Driven Development"=> 45,
	"Woah"=> 30,
	"Sit Down and Write"=> 30,
	"Pair Programming vs Noise"=> 45,
	"Rails Magic"=> 60,
	"Ruby on Rails: Why We Should Move On"=> 60,
	"Clojure Ate Scala (on my project)"=> 45,
	"Programming in the Boondocks of Seattle"=> 30,
	"Ruby vs. Clojure for Back-End Development"=> 30,
	"Ruby on Rails Legacy App Maintenance"=> 60,
	"A World Without HackerNews"=> 30,
	"User Interface CSS in Rails Apps"=> 30
}	
	
end
def get_event_times
	values = get_events.values	
end
# Distribute Time

# Each track has roughly 180-180 session
# Get Total Conference Time
# Get Total Track total time % 360  and divide by 360 you will get remainder if it less than 90 minute
# i.e minimum time Should be for nretworking will be 15 minute if we want less reduce remainder time
# Now First Get Pair of 180 hour
def schedule_events
	events = get_events
	values = get_event_times
	total_confernce_time = values.inject{|sum,x| sum + x }
	puts "Total Conference Time #{total_confernce_time}"
	total_session = total_confernce_time/180
	total_track_day =  total_session/2
	total_track_time_remain_time =  total_confernce_time-total_session*180
	
	if(total_track_time_remain_time>=90)
		total_track_day = total_track_day+1
		extra_session = 1
	end
	morning_session =  total_session/2
	afternoon_session = total_session+extra_session-morning_session
	puts "Total Morning Session #{morning_session} and extra session #{extra_session}"
	puts "Total Afternoon Session #{afternoon_session}"
	puts "Total track #{total_track_day}"
	# Segregate Time in a 180 group and other in a remiaining time
	# Now we have to find out exact 180 minutes of morning session
	group_by_minutes(values)

end

def group_by_minutes(values)
	group_values = []
	sorted_values = values.sort.reverse
	sorted_values.each do |x|
		
	end
end
schedule_events