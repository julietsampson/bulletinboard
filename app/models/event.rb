class Event < ActiveRecord::Base
    has_and_belongs_to_many :students
    belongs_to :organizers

    def self.all_tags
        return ["Freshman", "Sophomore", "Junior", "Senior", "STEM", "Humanities", "Free Food", "Academic", "Professional", "Social", "When I'm Free"]
    end
    def self.with_tags(tags_list,sort_by)
      Event.where('array_length(tags, 1) is NULL OR tags && array[?]', tags_list)
      end
end
