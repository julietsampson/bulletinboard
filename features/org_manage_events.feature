Feature: manage events as an organizer

  As an organizer
  I want to create and modify the events

Background: 

  Given a valid organizer
  And this organizer has the following events:
  | name                   | datetime    | location    | description | tags |
  | pumpkin carving        | 31-Oct-2022 | East Campus | Fun!        | food |
  And I am on organizer sign in page
  When I fill in 'Org Name' with 'CucumberTestUser'
  And I fill in 'Email' with 'ab@columbia.edu'
  And I fill in 'Org Password' with 'pass'
  And I press "Organization Login"
  Then I am on org events page for "CucumberTestUser"


Scenario: Organization can see all events they have created

  Given I am on org events page for "CucumberTestUser"
  Then  I should see all my created events

Scenario: Organization can create an event
  When I follow "Create an event"
  Then I should go to event creation page 
  When I fill in 'Event Name' with 'Party!'
  And I fill in 'Location' with 'Uris'
  And I check the "Senior" checkbox
  And I fill in 'Description' with 'Come join us for fun'
  When I press "Save Changes"
  Then I should go to org events page for "CucumberTestUser"
  And I should see "Party!"

  Scenario: Organization can't create an event with no name
  When I follow "Create an event"
  Then I should go to event creation page 
  When I fill in 'Location' with 'Uris'
  And I check the "Senior" checkbox
  And I fill in 'Description' with 'Come join us for fun'
  When I press "Save Changes"
  Then I should be on event creation page
  And I should see "Please fill in the required fields."

Scenario: Organization can delete an event
  When I follow "More about pumpkin carving"
  Then I should go to the info page for "pumpkin carving"
  When I follow "Delete"
  And I go to org events page for "CucumberTestUser"
  Then I should not see "pumpkin carving"

Scenario: Organization can edit an event
  When I go to the edit page for "pumpkin carving"
  And I fill in 'Location' with 'Uris'
  And I check the "Senior" checkbox
  And I press "Update Event Info"
  Then the location of "pumpkin carving" should be "Uris"

  Scenario: Organization can't edit an event to have no name
  When I go to the edit page for "pumpkin carving"
  And I fill in 'Name' with ''
  And I fill in 'Location' with 'Uris'
  And I check the "Senior" checkbox
  And I press "Update Event Info"
  Then I should be on the edit page for "pumpkin carving"
  And I should see "Please fill in the required fields."




  
  
