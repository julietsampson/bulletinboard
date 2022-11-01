Feature: logged in as a student

  As a student
  I want to log in

Background: 

  Given a valid student user
 
   
Scenario: Student signs in with correct credentials

  When I go to sign in page
  And I fill in 'Name' with 'User User'
  And I fill in 'UNI' with 'ab1234'
  And I fill in 'Password' with 'pass'
  When I press "Student Login"
  Then I should go to event page
  
Scenario: Student tries to sign in with incorrect password

  When I go to sign in page
  And I fill in 'Name' with 'User User'
  And I fill in 'UNI' with 'ab1234'
  And I fill in 'Password' with 'bla'
  When I press "Student Login" 
  Then I should see "Password incorrect. Please try again!"