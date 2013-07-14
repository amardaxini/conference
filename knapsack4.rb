require 'rubygems'
require 'pry'
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
weights = [5, 30, 30, 30, 30, 30, 30, 30, 45, 45, 45, 45, 45, 45, 60, 60, 60, 60, 60]
total_items = weights.size
sum= weights.inject{|sum,x| sum + x }

