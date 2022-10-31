Given /^a valid student user$/ do
  @student = Student.create!({
        :name => "User User",
        :uni => "ab1234",
        :password => "pass",
      })
end

Then /I should see all the events/ do
    
    rows = page.all('tbody tr').count
    expect(rows).to eq Event.count
  end
