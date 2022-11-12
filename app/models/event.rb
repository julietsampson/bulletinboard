class Event < ActiveRecord::Base
    has_and_belongs_to_many :students
    belongs_to :organizers

    def self.all_tags
        return ["Freshman", "Sophomore", "Junior", "Senior", "STEM", "Humanities", "Free Food"]
    end
end
