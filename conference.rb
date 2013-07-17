require 'rubygems'
require 'pry'
require_relative './event'
require_relative './event_schedular'
require_relative './track'
class Conference
  attr_accessor :events,:total_conference_time,:total_track_day,:total_session
  attr_accessor :event_schedules,:tracks
  attr_accessor :restart_scheduling_count
  def initialize
    @events = []
    @tracks = []
    @event_schedules = []
    @restart_scheduling_count =  0
  end
  
  def add_event(name)
    if Event.is_valid?(name)
      @events << Event.add_event(name)
    else
      raise EventException.new('Event should be @name @durationmin or @name lightning')  
    end
    
  end
  
  def display_events

    @events.each_with_index do |event,i|
      puts "#{i+1}. #{event.name} : #{event.duration}"
    end
  end
  
  def total_events
    @events.size  
  end
  
  def schedule_events
    set_conference_parameter
    set_tracks
    set_sessions
  end
  
  def set_conference_parameter
    set_total_confernce_time
    # Assuming Each conference has 180 min
    @total_session = @total_conference_time/180
    @total_session = @total_session+1 if(@total_conference_time < 360)
    
    total_track_time_remain_time =  @total_conference_time-@total_session*180
    # Taking 90 min buffer for  it means for atleast 45 minute for each after noon session
    # IF it's 90 then 15 min networking event for each track
    if(total_track_time_remain_time>45*(@total_session/2))
      @total_session = @total_session+1
	  end
    @total_track_day =  (@total_session/2.0).ceil
  end
  
  def set_total_confernce_time
    @total_conference_time =  @events.map(&:duration).inject{|sum,x| sum + x }
  end


  def set_tracks
    @tracks = []
    (1..total_track_day).each do |i|
      @tracks << Track.new(i)
    end
  end  

  def get_events_for_duration(duration=180)
    event_schedular = EventSchedular.new
    remaining_events = @events - @event_schedules
    event_schedular.add_events(remaining_events)
    event_schedular.schedule_events
    event_schedular.get_events_for_duration(duration)
  end

  def set_sessions
    @tracks.each_with_index do |track,index|
      events = get_events_for_duration(180)
      track.set_morning_session(events)
      @event_schedules +=events
      events = get_events_for_duration(225)
      if(!events.empty?)
        @event_schedules +=events
        track.set_afternoon_session(events)
      end  
      @event_schedules.flatten.compact
    end
  end

  # Identify First 180 i.e first morning session
  # then find out remaining duration decrease total session by1
  # Now if remaining duration is  less than equal 180*total session
  # then find out nearer 180 event duration
  # else find out remaining morning session*180 and subtract from remaining duration
  # get remaining no of after noon session divide by them with remaining duration so
  # We will get extra time and we try to divide in equal timing so probably we get equal
  # Networking event
  # Some times event is big so if unit extra time is more than 45 than set to 45
  # TODO Or we can have first track has max conference
  # def old_set_sessions
  #   total_sessions = @total_session
  #   remaining_duration = @total_conference_time
  #   @tracks.each_with_index do |track,index|
  #     if(remaining_duration >180)
  #       events = get_events_for_duration(180)
  #     else
  #       events = get_events_for_duration(remaining_duration)
  #     end 
  #     track.set_morning_session(events)
  #     durations = events.inject(0) {|sum,x| sum+x.duration}
  #     remaining_duration = remaining_duration - durations
  #     total_sessions = total_sessions - 1
  #     if(total_sessions>0)
        
  #       if(remaining_duration <= 180*total_sessions)

  #         if(remaining_duration <180)
  #           events = get_events_for_duration(remaining_duration)
  #         else  
  #           events = get_events_for_duration(225)
  #         end
  #       else
  #         no_of_morning_session = total_sessions/2
  #         no_of_afternoon_session = total_sessions - no_of_morning_session
  #         unit_extra_time = (remaining_duration - 180*total_sessions)/no_of_afternoon_session
          
  #         unit_extra_time = 45 if(unit_extra_time>45)
  #         events = get_events_for_duration(180+unit_extra_time)
  #       end  
  #       track.set_afternoon_session(events)
  #       durations = events.inject(0) {|sum,x| sum+x.duration}
  #       remaining_duration = remaining_duration - durations
  #       total_sessions = total_sessions - 1
  #     end  
  #   end
  # end

  
  def display_tracks
    conference_string =""
    @tracks.each do |x| 
      conference_string += x.display_track 
      conference_string += "\n"
    end
    puts conference_string
    conference_string
  end

  
end


