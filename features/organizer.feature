Feature: logged in as an organizer

  As an organizer
  I want to create and modify the events

Background: 

  Given a valid user
  When  I go to the login page
  An    I fill in the following:
            |name|User|
            |email|ab@columbia.edu|
            |password|pass|
  And   I press "Login"
  Then  I should see organizer index page
   
Scenario: Signing in with correct credentials
  When I go to sign in page
  And I fill in "name" with "User User"
  And I fill in "email" with "ab@columbia.edu"
  And I fill in "password" with "pass"
  And I click "Login" button
  Then I should see index page
  
Scenario: User tries to sign in with incorrect password
  When I go to sign in page
  And I fill in "name" with "User User"
  And I fill in "email" with "ab@columbia.edu"
  And I fill in "password" with "bla"
  And I click "Login" button
  Then I should see "Invalid credentials"

Scenario: Events List

  Given I am logged in as "email" with password "pass"
  When  I am on the organizer index page
  Then  I should see all the created events
  

Scenario: create events

  Given I am on the organizer index page
  When  I follow "Create an event"
  Then  I should be on the new page 
  And   I should see fields to create new event
  And   I should be able to save the new event

Scenario: modify event
  Given I am on the organizer index page
  Then  I  
  When  I 
  Then  I 
  And   I 
