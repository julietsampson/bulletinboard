Given /^a valid student user$/ do
  @student = Student.create!({
        :name => "CucumberTestStudent",
        :uni => "ab1234",
        :password => "pass",
      })
end

Then /I should see all the events/ do
    
    rows = page.all('tbody tr').count
    expect(rows).to eq Event.count
  end

  Then /my event list should be updated/ do
    
    rows = page.all('tbody tr').count
    expect(rows).to eq @student.events.count
  end
