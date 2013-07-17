require 'rubygems'
require 'pry'
require_relative './event'
require_relative './track'
class Conference
  attr_accessor :events,:total_conference_time,:total_track_day,:total_session
  attr_accessor :event_duration_matrix,:event_keep_matrix,:event_matrix,:tracks
  attr_accessor :restart_scheduling_count
  def initialize
    @events = []
    @tracks = []
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
    set_event_schedular_matrix
    set_tracks
    set_sessions
    display_tracks

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

  def total_afternoon_session
    @total_session/2
  end
  def total_morning_session
    @total_session/2+1
  end

  # in event_keep_matrix row will be the no of event
  # column will be the duration
  def set_event_schedular_matrix
    max_duration = 225
    durations = @events.collect(&:duration)
    
    duration_significance = durations.each {|x|x/durations.size }
    @event_duration_matrix = [].tap { |m| (total_events+1).times { m << Array.new(max_duration+1) } }
    @event_duration_matrix[0].each_with_index { |value, index| @event_duration_matrix[0][index] = 0 }
    @event_keep_matrix = [].tap { |m| (total_events+1).times { m << Array.new(max_duration+1) } }
    @event_keep_matrix[0].each_with_index { |value, index| @event_keep_matrix[0][index] = 0 }
    set_schedular(durations,duration_significance,max_duration)
    @event_matrix = @event_keep_matrix
  end
  
  # Knapsack
  def set_schedular(durations,duration_significance,max_duration)
    (1..total_events).each do |i|
      significance_value, = duration_significance[i-1]
      duration=  durations[i-1]
      (0..max_duration).each do |x|
      
        if duration > x
          @event_duration_matrix[i][x] = @event_duration_matrix[i-1][x]
          @event_keep_matrix[i][x] = 0
        else
          @event_duration_matrix[i][x] = [@event_duration_matrix [i-1][x],
           @event_duration_matrix[i-1][x-duration] + significance_value].max
           
          if((@event_duration_matrix[i-1][x-duration] + significance_value) < @event_duration_matrix[i-1][x])
            @event_keep_matrix[i][x] = 0
          else
            @event_keep_matrix[i][x] = 1
          end
        end
      end
    end
  end
  
  def set_tracks
  
    (1..total_track_day).each do |i|
      @tracks << Track.new(i)
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
  def set_sessions

    total_sessions = @total_session
    remaining_duration = @total_conference_time
    @tracks.each_with_index do |track,index|
      
      if(remaining_duration >180)
        events = get_events_for_duration(180)
      else
        events = get_events_for_duration(remaining_duration)
      end  
      track.set_morning_session(events)
      durations = events.inject(0) {|sum,x| sum+x.duration}
      remaining_duration = remaining_duration - durations
      total_sessions = total_sessions - 1
      if(total_sessions>0)
        
        if(remaining_duration <= 180*total_sessions)

          if(remaining_duration <180)
            events = get_events_for_duration(remaining_duration)
          else  
            events = get_events_for_duration(225)
          end
        else
          no_of_morning_session = total_sessions/2
          no_of_afternoon_session = total_sessions - no_of_morning_session
          unit_extra_time = (remaining_duration - 180*total_sessions)/no_of_afternoon_session
          
          unit_extra_time = 45 if(unit_extra_time>45)
          events = get_events_for_duration(180+unit_extra_time)
        end  
        track.set_afternoon_session(events)
        durations = events.inject(0) {|sum,x| sum+x.duration}
        remaining_duration = remaining_duration - durations
        total_sessions = total_sessions - 1
      end  
      
    end  

  end
  # Identify whole 180 minutes event if possible.

  # def set_morning_sessions
    
  # end
  # # Max 225 minutes of event so starting from 225 minutes
  # def set_afternoon_sessions
  #   afternoon_session = @total_session/2
  #   @tracks.each do |track|
  #     if(afternoon_session > 0)
  #       events = get_events_for_duration(225)
  #       track.set_afternoon_session(events)
  #       afternoon_session = afternoon_session-1
  #     end
  #   end
  # end
  
  
  # From event matrix it will fetch duration and set 0 
  # so same event can't be repeated
  # It will start from last event and check for duration
  # Suppose Searching for 180 total event is 20
  # Last event is wworth of 30 min now
  # next event will be 19 and it will try to search on 180-30=150 
  # if it's 1 then add it other wise go to next event i.e 18
  def get_events_for_duration(duration)
    events = []
   
    total_events.downto(0).each do |i|
      if(@event_matrix[i][duration] == 1)
        event = @events[i-1]
        @event_matrix[i].each_with_index { |value, index| @event_matrix[i][index] = 0 }
        duration = duration - event.duration
        events << event
      end
    end  
    
    events
  end
  
  def display_tracks
    conference_string =""
    @tracks.each do |x| 
      conference_string += x.display_track 
      conference_string += "\n"
    end
    puts conference_string
    conference_string
  end

  def check_all_event_is_scheduled?
    total_event_scheduled = 0
    @tracks.each do |track|
      total_event_scheduled +=track.get_all_session_events.size
    end
    @events.size == total_event_scheduled
  end
  private
    def empty_tracks
      @tracks.each do |track|
        track.empty_track
      end
    end

    def restart_scheduling
      unless check_all_event_is_scheduled? 
        if @restart_scheduling_count < 5
          empty_tracks
          @events.shuffle
          @restart_scheduling_count +=  1
          puts "Restart #{@restart_scheduling_count}"
          schedule_events
        end  
      end
    end


  
end


