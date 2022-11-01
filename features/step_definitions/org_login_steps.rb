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