Feature: manage events as an organizer

  As an organizer
  I want to create and modify the events

Background: 

  Given a valid organizer
  And this organizer has the following events:
  | name                   | datetime    | location    | description | tags |
  | pumpkin carving        | 31-Oct-2022 | East Campus | Fun!        | food |
  And I am on the sign in page
  When I fill in 'Org Name' with 'CucumberTestUser'
  And I fill in 'Email' with 'ab@columbia.edu'
  And I fill in 'Org Password' with 'pass'
  And I press "Organization Login"
  Then I am on the org events page


Scenario: Organization can see all events they have created

  Given I am on the org events page
  Then  I should see all my created events

Scenario: Organization can create an event
  When I follow "Create an event"
  Then I should go to event creation page 
  When I fill in 'Event Name' with 'Party!'
  And I fill in 'Location' with 'Uris'
  And I fill in 'Tags' with 'Food, Fun'
  And I fill in 'Description' with 'Come join us for fun'
  When I press "Save Changes"
  Then I should go to org events page
  And I should see "Party!"

Scenario: Organization can delete an event
  When I follow "More about pumpkin carving"
  Then I should go to the info page for "pumpkin carving"
  When I follow "Delete"
  And I go to org events page
  Then I should not see "pumpkin carving"

Scenario: Organization can edit an event
  When I go to the edit page for "pumpkin carving"
  And I fill in 'Location' with 'Uris'
  And I press "Update Event Info"
  Then the location of "pumpkin carving" should be "Uris"


  
  
