require 'rubygems'
require 'pry'
require_relative "./session"
require_relative "./session_helper"
class MorningSession < Session
  START_TIME= 540
  END_TIME= 720
  include SessionHelper

  def display_session
  	event_string = "Morning Session\n\n"
  	event_string += display_events
  	if total_duration ==180
  		event_string +="12:00PM Lunch \n"
  	else
  		event_string+= "12:00PM Lunch \n"
  	end
  	event_string

  end

  def self.class_name
  	"Morning Session"
  end
  
end
