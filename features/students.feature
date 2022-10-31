Feature: logged in as a student

  As a student
  I want to view and sign up for the events

Background: 

  Given a valid student user
 
   
Scenario: Signing in with correct credentials

  When I go to sign in page
  And I fill in 'Name' with 'User User'
  And I fill in 'UNI' with 'ab1234'
  And I fill in 'Password' with 'pass'
  When I press "Login_student"
  Then I should go to event page
  
Scenario: User tries to sign in with incorrect password

  When I go to sign in page
  And I fill in 'Name' with 'User User'
  And I fill in 'UNI' with 'ab1234'
  And I fill in 'Password' with 'bla'
  When I press "Login_student" 
  Then I should see "Password incorrect. Please try again!"

Scenario: Events page

  When I go to sign in page
  And I fill in 'Name' with 'User User'
  And I fill in 'UNI' with 'ab1234'
  And I fill in 'Password' with 'pass'
  When I press "Login_student"
  Then I should go to event page
  Then I should see all the events
  When I press "My Events" 

  
