Given /^a valid organizer$/ do
  @organization = Organizer.create!({
             :name => "CucumberTestUser",
             :email => "ab@columbia.edu",
             :password => "pass",
           })
end

Then /I should see all my created events/ do
    rows = page.all('tbody tr').count
    expect(rows).to eq @organization.events.count
  end

  Given /this organizer has the following events/ do |events_table|
    events_table.hashes.each do |event|
      to_add = @organization.events.create(event)
    end
  end

  Then /the location of "(.*)" should be "(.*)"/ do |event_name, place|
    step %{I should be on the info page for "#{event_name}"}
    page.find('#location').should have_text(place)
  end