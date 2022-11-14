require 'rails_helper'

describe Event do
  describe '.with_tags works as intended' do
    test_event = Event.create(:name => "spec testing event", :tags => ["Freshman", "STEM"])
    test_event_2 = Event.create(:name => "spec testing event 2 ", :tags => ["Freshman"])
    test_org = Organizer.find_by(:email => "spectestorg@gmail.com")
    if (test_org == nil)
      test_org = Organizer.create(:name => "spec testing organizer",  :email => "spectestorg@gmail.com", :password => "pass")
    end
    test_org.events << test_event

    it 'returns a list of all Events when no tags are specified' do
        tags_list = nil
        sort_by = nil
        expect(Event.with_tags(tags_list, sort_by)).to eq(Event.all)
    end

    it 'returns only Events with matching tags when tags are specified' do
        tags_list = ["Freshman", "STEM"]
        sort_by = nil
        expect(Event.with_tags(tags_list, sort_by)).to include(test_event)
    end
  end
end