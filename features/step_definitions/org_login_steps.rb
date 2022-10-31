Given /^a valid organizer$/ do
  @organization = Organizer.create!({
             :name => "User",
             :email => "ab@columbia.edu",
             :password => "pass",
           })
end

Then /I should see all the created events/ do
    rows = page.all('tbody tr').count
    expect(rows).to eq Event.count
  end