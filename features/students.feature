Feature: logged in as a student

  As a student
  I want to view and sign up for the events

Background: 
  Given a valid user
  When  I go to the login page
  An    I fill in the following:
            |name|User|
            |uni|ab1234|
            |password|pass|
  And   I press "Login"
  Then  I should see index page
   
Scenario: Signing in with correct credentials
  When I go to sign in page
  And I fill in "name" with "User User"
  And I fill in "uni" with "ab1234"
  And I fill in "password" with "pass"
  And I click "Login" button
  Then I should see index page
  
Scenario: User tries to sign in with incorrect password
  When I go to sign in page
  And I fill in "name" with "User User"
  And I fill in "uni" with "ab1234"
  And I fill in "password" with "bla"
  And I click "Login" button
  Then I should see "Invalid credentials"

Scenario: Events List

  Given I am logged in as "uni" with password "pass"
  When  I am on the index page
  Then  I should see all the events
  
