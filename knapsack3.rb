require 'rubygems'
require 'pry'
class Array
  # do something for each element of the array's power set
  def power_set
    yield [] if block_given?
    self.inject([[]]) do |ps, elem|
      r = []
      ps.each do |i|
        r << i
        new_subset = i + [elem]
        yield new_subset if block_given?
        r << new_subset
      end
      r
    end
  end
end
KnapsackItem = Struct.new(:name, :weight, :value)
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
potential_items =[]
sum=[5, 30, 30, 30, 30, 30, 30, 30, 45, 45, 45, 45, 45, 45, 60, 60, 60, 60, 60].inject{|sum,x| sum + x }
events.each {|k,v| potential_items.push(KnapsackItem.new(k,v,v/19) )}

knapsack_capacity = 180
 
maxval = 0
solutions = []

potential_items.power_set do |subset|
  binding.pry
  weight = subset.inject(0) {|w, elem| w += elem.weight}
  next if weight > knapsack_capacity
 
  value = subset.inject(0) {|v, elem| v += elem.value}
  if value == maxval
    solutions << subset
  elsif value > maxval
    maxval = value
    solutions = [subset]
  end
end
puts "value: #{maxval}"
binding.pry
solutions.each do |set|
  items = []
  wt = 0
  set.each {|elem| wt += elem.weight; items << elem.name+": "+elem.weight.to_s+
"\n"}
  puts "weight: #{wt}"
  puts "items: #{items.sort.join(',')}"
end
