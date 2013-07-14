require 'rubygems'
require 'pry'

b= [60, 60, 60, 60, 60, 45, 45, 45, 45, 45, 45, 30, 30, 30, 30, 30, 30, 30, 5]
a=b
	y =[]
def grouping(a,y,summation=180)
	i = 0
	sum = 0
	last_track_index = []
	while(i<a.size)
		sum = sum+a[i]
		binding.pry
		if(sum==summation)
			last_track_index.push(i)
			y.push(last_track_index)
			last_track_index.collect do |x|
					a.delete_at(x)
			end	
			puts "#{y}"
			grouping(a,y)

			return y
		elsif(sum<summation)	
			last_track_index.push(i)
		elsif(sum>summation)
			sum 	= sum - a[i]
			last_track_index.pop(i)
		end	
		i= i+1
	end
	

 end
# binding.pry
 grouping(a,y)

