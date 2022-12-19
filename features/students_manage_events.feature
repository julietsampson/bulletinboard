Feature: manage events as a student

  As a student
  I want to manage events

Background: 
  Given a valid student user
  And I am on student sign in page
  And the following events exist:
    | name                   | datetime    | location    | description | tags |
    | pumpkin carving        | 31-Oct-2022 | East Campus | Fun!        | Freshman, STEM |
    | movie night            | 30-Oct-2022 | Lerner      | Marvel marathon | Junior, Humanities, Free Food |
  And the following events are on my events list:
    | name                   | datetime    | location    | description     | tags |
    | movie night            | 30-Oct-2022 | Lerner      | Marvel marathon | Junior, Humanities, Free Food |
  And I fill in 'Name' with 'CucumberTestStudent'
  And I fill in 'UNI' with 'ab1234@columbia.edu'
  And I fill in 'Password' with 'pass'
  And I press "Student Login"
  Then I am on event page

Scenario: View all created events
  Given I check the following tags: Freshman,Sophomore,Junior,Senior,STEM,Humanities
  And I check "Free Food" checkbox
  And I press "Filter"
  Then I should see all the events

Scenario: Filter existing events
  When I check the following tags: Freshman,STEM
  And I uncheck the following tags: Sophomore,Junior,Senior,Humanities
  And I uncheck "Free Food" checkbox
  When I press "Filter" 
  Then I should see "pumpkin carving"
  Then I should not see "movie night"

Scenario: Filter based on availability
  When I press "My Profile"
  Then I should go to my profile page
  When I follow "View Schedule"
  Then I should go to my schedule page
  When I follow "Edit Schedule"
  Then I should go to edit schedule page
  Given I am on edit schedule page
  When I select "Sunday" from "Day"
  And I select time "12 AM:00" from "timeblock_busy_start"
  And I select time "11 PM:59" from "timeblock_busy_end"
  And I press "Add"
  Then I should see "Schedule was successfully updated."
  And I press "All Events"
  Then I am on event page
  Given I check the following tags: Freshman,Sophomore,Junior,Senior,STEM,Humanities
  And I uncheck the following tags: When I'm Free
  And I press "Filter"
  Then I should see all the events
  When I check the following tags: When I'm Free
  When I press "Filter" 
  Then I should see "pumpkin carving"
  Then I should not see "movie night"
  

Scenario: Add event to my event list and try readding and deleting it
  When I go to the about page for "pumpkin carving"
  When I follow "Add"
  Then I should go to my event list page
  And my event list should be updated
  And I should see "pumpkin carving"
  When I go to the about page for "pumpkin carving"
  When I follow "Add"
  Then I should see "You've already added pumpkin carving to your list!"
  Then I should go to my event list page
  And I should see "pumpkin carving"
  And I press "Remove pumpkin carving"
  Then I should not see "pumpkin carving"




