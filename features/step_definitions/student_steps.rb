Given /^a valid student user$/ do
  @student = Student.create!({
        :name => "CucumberTestStudent",
        :uni => "ab1234",
        :password => "pass",
      })
end

Given /the following events exist/ do |events_table|
  @organization = Organizer.create!({
    :name => "CucumberTestUser",
    :email => "ab@columbia.edu",
    :password => "pass",
  })

  events_table.hashes.each do |event|
    to_add = @organization.events.create(event)
  end
end
  
Given /the following events are on my events list/ do |events_table|
  events_table.hashes.each do |event|
    @event = Event.find_by(:name => event[:name])
    @student.events << @event
  end
end

Then /I should see all the events/ do
    
    rows = page.all('tbody tr').count
    expect(rows).to eq Event.count
  end

Then /my event list should be updated/ do
    
    rows = page.all('tbody tr').count
    expect(rows).to eq @student.events.count
  end

When /^(?:|I )click "([^"]*)" for "([^"]*)"$/ do |button, event_name|
    event_id = Event.find_by(:name => event_name).id
    click_button(event_id.to_s)
end

