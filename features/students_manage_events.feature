Feature: manage events as a student

  As a student
  I want to manage events

Background: 
  Given a valid student user
  And I am on the sign in page
  And the following events exist:
    | name                   | datetime    | location    | description | tags |
    | pumpkin carving        | 31-Oct-2022 | East Campus | Fun!        | Senior, Humanities |
    | movie night            | 30-Oct-2022 | Lerner      | Marvel marathon | Free Food |
  And the following events are on my events list:
    | name                   | datetime    | location    | description     | tags |
    | movie night            | 30-Oct-2022 | Lerner      | Marvel marathon | Free Food |
  And I fill in 'Name' with 'CucumberTestStudent'
  And I fill in 'UNI' with 'ab1234'
  And I fill in 'Password' with 'pass'
  And I press "Student Login"
  Then I am on event page

Scenario: Navigate to and view all created events
  Given I am on event page
  Then I should see all the events

Scenario: Add event to my event list
  When I go to the about page for "pumpkin carving"
  When I follow "Add"
  Then I should go to my event list page
  And my event list should be updated
  And I should see "pumpkin carving"

