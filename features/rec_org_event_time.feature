Feature: receive recommendation for optimal event times as an organizer

  As an organizer
  I want to schedule 

Background:

  Given a valid organizer
  And this organizer has the following events:
  | name                   | datetime    | location    | description | tags |
  | pumpkin carving        | 31-Oct-2022 | East Campus | Fun!        | Junior, Humanities |
  And a valid student with name "Abby", uni "a1234", password "pass", and tags "Junior", "Humanities"
  And a valid student with name "Bella", uni "b1234", password "pass", and tags "Junior", "Humanities"
  And the student with uni "a1234" is busy on "Monday" from 09:00 to 10:00
  And I am on organizer sign in page
  When I fill in 'Org Name' with 'CucumberTestUser'
  And I fill in 'Email' with 'ab@columbia.edu'
  And I fill in 'Org Password' with 'pass'
  And I press "Organization Login"
  Then I am on org events page for "CucumberTestUser"

Scenario:
    When I go to the edit page for "pumpkin carving"
    Then I should see "We took a look at all the schedules of all 2 students in our database whose profiles indicate they might be interested in your event. Here are when they're most free (in military time):"
    And I should see "2 students are available for an event held on Monday at 8 o'clock EST."
    And I should see "2 students are available for an event held on Monday at 11 o'clock EST."
    And I should see "2 students are available for an event held on Monday at 12 o'clock EST."