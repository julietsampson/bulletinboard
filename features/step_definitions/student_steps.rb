Given /^a valid student user$/ do
  @student = Student.create!({
        :name => "CucumberTestStudent",
        :uni => "ab1234",
        :password => "pass",
      })
end

Given("a valid student with name {string}, uni {string}, password {string}, and tags {string}, {string}") do |name, uni, pass, tag_1, tag_2|
  @student = Student.create!({
    :name => name,
    :uni => uni,
    :password => pass,
    :tags => [tag_1, tag_2]
  })
end

Given("the student with uni {string} is busy on {string} from {int}:{int} to {int}:{int}") do |uni, day, start_hour, start_min, end_hour, end_min|
  @student = Student.find_by(:uni => uni)
  date_map = {"Monday" => "01-Jan-1996 ", "Tuesday" => "02-Jan-1996 ", "Wednesday" => "03-Jan-1996 ", "Thursday" => "04-Jan-1996 ", "Friday" => "05-Jan-1996 ", "Saturday" => "06-Jan-1996 ", "Sunday" => "07-Jan-1996 "}
  date = date_map[day]
  start_datetime = date + " " + start_hour.to_s + ":" + start_min.to_s + " " + "0000"
  end_datetime = date + " " + end_hour.to_s + ":" + end_min.to_s + " " + "+0000"
  @student.timeblocks.create(busy_range: (start_datetime.to_datetime..end_datetime.to_datetime))
end

Given /the following events exist/ do |events_table|
  @organization = Organizer.create!({
    :name => "CucumberTestUser",
    :email => "ab@columbia.edu",
    :password => "pass",
  })

  events_table.hashes.each do |event|
    event["tags"] = event["tags"].split(/\s*,\s*/)
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