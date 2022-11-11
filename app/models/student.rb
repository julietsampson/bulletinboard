class Student < ActiveRecord::Base
    has_and_belongs_to_many :events
    has_many :timeblocks

    def weekday_schedule
        mon = Date.new(1996,1,1)
        tue = Date.new(1996,1,2)
        wed = Date.new(1996,1,3)
        thu = Date.new(1996,1,4)
        fri = Date.new(1996,1,5)
        sat = Date.new(1996,1,6)
        sun = Date.new(1996,1,7)
        mon_sched = self.timeblocks.where("busy_range && tsrange(?, ?)", mon.beginning_of_day, mon.end_of_day).order('lower(busy_range)')
        tue_sched = self.timeblocks.where("busy_range && tsrange(?, ?)", tue.beginning_of_day, tue.end_of_day).order('lower(busy_range)')
        wed_sched = self.timeblocks.where("busy_range && tsrange(?, ?)", wed.beginning_of_day, wed.end_of_day).order('lower(busy_range)')
        thu_sched = self.timeblocks.where("busy_range && tsrange(?, ?)", thu.beginning_of_day, thu.end_of_day).order('lower(busy_range)')
        fri_sched = self.timeblocks.where("busy_range && tsrange(?, ?)", fri.beginning_of_day, fri.end_of_day).order('lower(busy_range)')
        sat_sched = self.timeblocks.where("busy_range && tsrange(?, ?)", sat.beginning_of_day, sat.end_of_day).order('lower(busy_range)')
        sun_sched = self.timeblocks.where("busy_range && tsrange(?, ?)", sun.beginning_of_day, sun.end_of_day).order('lower(busy_range)')
        schedule = {:mon => mon_sched, :tue => tue_sched, :wed => wed_sched, :thu => thu_sched, :fri => fri_sched, :sat => sat_sched, :sun => sun_sched}
        return schedule
    end
end
