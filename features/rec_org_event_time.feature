Feature: receive recommendation for optimal event times =as an organizer

  As an organizer
  I want to schedule 

Background:

  Given a valid organizer
  And this organizer has the following events:
  | name                   | datetime    | location    | description | tags |
  | pumpkin carving        | 31-Oct-2022 | East Campus | Fun!        | food |
  And a valid student with name "Abby," uni "a1234", and password "pass"
  And a valid student with name "Bella," uni "b1234", and password "pass"
  And a valid student with name "Cara," uni "c1234", and password "pass"
  And "Abby" has tag "Junior"
  And "Bella" has tag "Junior"
  And "Cara" has tag "Junior"
  And "Abby" is busy on Monday from 4:30 - 5:30 and on Tuesday from 12:00 - 1:00 and on Wednesday from 
  And "Bella" is busy on Monday from 4:30 - 5:30 and on Tuesday from 12:00 - 1:00



  And I am on the sign in page
  When I fill in 'Org Name' with 'CucumberTestUser'
  And I fill in 'Email' with 'ab@columbia.edu'
  And I fill in 'Org Password' with 'pass'
  And I press "Organization Login"
  Then I am on the org events page

Scenario:
