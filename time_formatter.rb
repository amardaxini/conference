require 'time'
class TimeFormatter
 
  def self.format_time(minutes)
    hours = (minutes/60) 
    minute = minutes- hours*60

    Time.parse("#{hours}:#{minute}").strftime("%I:%M%p") 
    
  end
end  
