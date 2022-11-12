class Student < ActiveRecord::Base
    has_and_belongs_to_many :events

    def self.all_tags
        return ["Freshman", "Sophomore", "Junior", "Senior", "STEM", "Humanities"]
    end
end
