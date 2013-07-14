require 'rubygems'
require 'pry'
require './event'
require './track'
class Conference
  attr_accessor :events,:total_conference_time,:total_track_day,:total_session
  attr_accessor :event_duration_matrix,:event_keep_matrix,:event_matrix,:tracks
  
  def initialize
    @events = []
    @tracks = []
  end
  

  
  def add_event(name)
    if Event.is_parse_event_correct?(name)
      @events << Event.add_parse_event(name)
      print "Event is successfully added"
    else
      # Raise exeception
      print "Event is in correct \n"
      print "Event will be '@eventname @durationmin'"
    end
    
  end
  
  def get_events

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
    
    @total_track_day =  (@total_session/2.0).ceil
    total_track_time_remain_time =  @total_conference_time-@total_session*180
    # Taking 90 min buffer for  it means for atleast 45 minute for each after noon session
    # IF it's 90 then 15 min networking event for each track
    
    if(total_track_time_remain_time>=90)
		  @total_track_day = @total_track_day+1
      @total_session = @total_session+1
	  end
  end
  
  def set_total_confernce_time
    @total_conference_time =  @events.map(&:duration).inject{|sum,x| sum + x }
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
  
  def set_sessions
    set_morning_sessions
    set_afternoon_sessions
  end
  def set_morning_sessions
    @tracks.each do |track|
      events = get_events_for_duration(180)
  
      track.set_morning_session(events)
    end  

  end
  
  def set_afternoon_sessions
    afternoon_session = @total_session/2
    @tracks.each do |track|
      if(afternoon_session > 0)
        events = get_events_for_duration(225)
        track.set_afternoon_session(events)
        afternoon_session = afternoon_session-1
      end
    end
  end
  
  
  # From event matrix it will fetch duration and set 0 so same ec=vent can't be repeated
  def get_events_for_duration(duration)
    events = []
    
    total_events.downto(0).each do |i|
      if(@event_matrix[i][duration] == 1)
        puts "element #{i} duration #{duration}"
        event = @events[i-1]
        @event_matrix[i].each_with_index { |value, index| @event_matrix[i][index] = 0 }
        duration = duration - event.duration
        events << event
      end
    end  
    
    events
  end
  
  def display_tracks
    @tracks.each {|x| x.print_track}
  end
  
end


