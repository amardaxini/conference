require 'rubygems'
require 'optparse'
require 'pry'
require './conference'

conference = Conference.new
begin 
  print "Enter 1 for adding events \n 2 for showing events \n 3 for show conference \n 4 for quit choice\n"

  choice = gets.chomp.to_i
  
  if(choice==1)
    
    print "Enter event name"
    name = gets.chomp
    conference.add_event(name)
    
  elsif(choice==2)
    conference.display_events
    
  
  elsif(choice==3)
    conference.schedule_events
    conference.display_tracks
  elsif(choice==4)
  else
    puts "Invalid Choice"  
  end
end while choice!=4



