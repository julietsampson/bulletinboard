Feature: logged in as an organizer

  As an organizer
  I want to create and modify the events

Background: 

  Given a valid organizer
  

Scenario: Signing in with correct credentials

  When I go to sign in page
  And I fill in 'orgName' with 'User User'
  And I fill in 'Email' with 'ab@columbia.edu'
  And I fill in 'orgPassword' with 'pass'
  When I press "Login_org"
  Then I should go to org events page
  
Scenario: User tries to sign in with incorrect password

  When I go to sign in page
  And I fill in 'orgName' with 'User User'
  And I fill in 'Email' with 'ab@columbia.edu'
  And I fill in 'orgPassword' with 'bla'
  When I press "Login_org"
  Then I should see "Password incorrect. Please try again!"

Scenario: Events List

  Given I am on the org events page
  Then  I should see all the created events
  

Scenario: create events and delete events
  When I go to sign in page
  And I fill in 'orgName' with 'User User'
  And I fill in 'Email' with 'ab@columbia.edu'
  And I fill in 'orgPassword' with 'pass'
  When I press "Login_org"
  Then I should go to org events page
  When I go to org events page
  When I follow "Create an event"
  Then I should go to new page 
  And I fill in 'Event Name' with 'Party!'
  And I fill in 'Location' with 'Uris'
  And I fill in 'Tags' with 'Food, Fun'
  And I fill in 'Description' with 'Come join us for fun'
  When I press "Save Changes"
  Then I should go to org events page
  And I should see "Party!"
  When I follow "More about Party!"
  Then I should go to info page
  When I follow "Delete"
  And I should see "Event 'Party!' deleted"
  When I go to org events page
  And I should not see "Party!"




  
  
