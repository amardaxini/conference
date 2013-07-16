require 'rubygems'
require 'pry'
require_relative "./session"
require_relative "./session_helper"
class AfternoonSession < Session
  START_TIME= 780
  END_TIME= 1005
  include SessionHelper

  
  def display_session
  	event_string = "Afternoon Session\n\n"
  	event_string += display_events
  	if total_duration >180
  		event_string +="#{TimeFormatter.format_time(total_duration+START_TIME)} Networking Event \n"
  	else
  		event_string +="04:00PM Networking Event \n"
  	end
  	event_string
  end

  def self.class_name
  	"Afternoon Session"
  end
end
