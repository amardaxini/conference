require 'rubygems'
require 'pry'
KnapsackItem = Struct.new(:name, :cost, :value)
KnapsackProblem = Struct.new(:items, :max_cost)
 
def dynamic_programming_knapsack(problem)
  num_items = problem.items.size
  items = problem.items
  max_cost = problem.max_cost
 
  cost_matrix = zeros(num_items, max_cost+1)
 
  num_items.times do |i|
    (max_cost + 1).times do |j|
      if(items[i].cost > j)
        cost_matrix[i][j] = cost_matrix[i-1][j]
      else
        cost_matrix[i][j] = [cost_matrix[i-1][j], items[i].value + cost_matrix[i-1][j-items[i].cost]].max
      end
    end
  end
 
  cost_matrix
end
 
def get_used_items(problem, cost_matrix)
  i = cost_matrix.size - 1
  currentCost = cost_matrix[0].size - 1
  marked = Array.new(cost_matrix.size, 0) 
 
  while(i >= 0 && currentCost >= 0)
    if(i == 0 && cost_matrix[i][currentCost] > 0 ) || (cost_matrix[i][currentCost] != cost_matrix[i-1][currentCost])
      marked[i] = 1
      currentCost -= problem.items[i].cost
    end
    i -= 1
  end
  marked
end
 
def get_list_of_used_items_names(problem, cost_matrix)
  items = problem.items
  used_items = get_used_items(problem, cost_matrix)
 
  result = []
  binding.pry
  used_items.each_with_index do |item,i|
    if item > 0
      result << items[i].name+": "+items[i].cost.to_s+"\n"
    end
  end
 
  result.sort.join('')
end
 
def zeros(rows, cols)
  Array.new(rows) do |row|
    Array.new(cols, 0)
  end
end
 
if $0 == __FILE__
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
	items = []
	sum=[5, 30, 30, 30, 30, 30, 30, 30, 45, 45, 45, 45, 45, 45, 60, 60, 60, 60, 60].inject{|sum,x| sum + x }
	events.each {|k,v| items.push(KnapsackItem.new(k, v, v/19) )}
	
  problem = KnapsackProblem.new(items, 180)
 
  cost_matrix = dynamic_programming_knapsack problem
  puts
  puts 'Dynamic Programming:'
  puts
  puts 'Found solution: ' + get_list_of_used_items_names(problem, cost_matrix)
  puts 'With value: ' + cost_matrix.last.last.to_s
end
