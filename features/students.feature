Feature: logged in as a student

  As a student
  I want to view and sign up for the events

Background: 

  Given a valid student user
 
   
Scenario: Student signs in with correct credentials

  When I go to sign in page
  And I fill in 'Name' with 'User User'
  And I fill in 'UNI' with 'ab1234'
  And I fill in 'Password' with 'pass'
  When I press "Login_student"
  Then I should go to event page
  
Scenario: Student tries to sign in with incorrect password

  When I go to sign in page
  And I fill in 'Name' with 'User User'
  And I fill in 'UNI' with 'ab1234'
  And I fill in 'Password' with 'bla'
  When I press "Login_student" 
  Then I should see "Password incorrect. Please try again!"

Scenario: Navigate to and view all created events

  When I go to sign in page
  And I fill in 'Name' with 'User User'
  And I fill in 'UNI' with 'ab1234'
  And I fill in 'Password' with 'pass'
  When I press "Login_student"
  Then I should go to event page
  Then I should see all the events

Scenario: Add and remove events from my list
  When I go to sign in page
  And I fill in 'Name' with 'CucumberTestStudent'
  And I fill in 'UNI' with 'ab1234'
  And I fill in 'Password' with 'pass'
  When I press "Login_student"
  When I go to event about page
  When I follow "Add"
  Then I should go to my event list page
  Then my event list should be updated


  
