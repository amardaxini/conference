require 'rubygems'
require 'pry'
knapsack_size, number_of_items = 180,19
weights=[5, 30, 30, 30, 30, 30, 30, 30, 45, 45, 45, 45, 45, 45, 60, 60, 60, 60, 60]
values = weights.each {|x|x/weights.size }
knapsack_size, number_of_items = 180,weights.size
cache = [].tap { |m| (number_of_items+1).times { m << Array.new(knapsack_size+1) } }
keep = [].tap { |m| (number_of_items+1).times { m << Array.new(knapsack_size+1) } }
cache[0].each_with_index { |value, weight| cache[0][weight] = 0 }
keep[0].each_with_index { |value, index| keep[0][weight] = 0 }
@iterations = 0
binding.pry
(1..number_of_items).each do |i|
  value, = values[i-1]
  weight=  weights[i-1]
  (0..knapsack_size).each do |x|
    @iterations = @iterations+1
    # puts "weight: #{weight}, x: #{x}, i:#{i}"
    if weight > x
      cache[i][x] = cache[i-1][x]
      keep[i][x] = 0
    else
      cache[i][x] = [cache[i-1][x], cache[i-1][x-weight] + value].max
      if((cache[i-1][x-weight] + value) < cache[i-1][x])
        keep[i][x] = 0
      else
        keep[i][x] = 1
      end
    end
  end
end
p cache[number_of_items][knapsack_size]
binding.pry
puts "Iterations: #{@iterations}"

