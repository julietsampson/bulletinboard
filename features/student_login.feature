Feature: logged in as a student

  As a student
  I want to log in

Background: 

  Given a valid student user
 
   
Scenario: Student signs in with correct credentials

  When I go to student sign in page
  And I fill in 'Name' with 'CucumberTestStudent'
  And I fill in 'UNI' with 'ab1234'
  And I fill in 'Password' with 'pass'
  When I press "Student Login"
  Then I should go to event page
  
Scenario: Student tries to sign in with incorrect password

  When I go to student sign in page
  And I fill in 'Name' with 'CucumberTestStudent'
  And I fill in 'UNI' with 'ab1234'
  And I fill in 'Password' with 'bla'
  When I press "Student Login" 
  Then I should see "Name or password incorrect. Please try again!"

Scenario: Student tries to sign in with incorrect name

  When I go to student sign in page
  And I fill in 'Name' with 'User'
  And I fill in 'UNI' with 'ab1234'
  And I fill in 'Password' with 'pass'
  And I press "Student Login"
  Then I should see "Name or password incorrect. Please try again!"

Scenario: Student tries to sign in with unknown uni

  When I go to student sign in page
  And I fill in 'Name' with 'CucumberTestStudent'
  And I fill in 'UNI' with 'ab0000'
  And I fill in 'Password' with 'pass'
  And I press "Student Login"
  Then I should see "User not found-- please try again or create an account!"


Scenario: Student does not fill out all fields to create an account
  When I go to student sign in page
  And I fill in 'Name?' with ''
  And I fill in 'UNI?' with 'ab1234'
  And I fill in 'Password?' with 'bla'
  When I press "Create Student Account"
  Then I should see "Please fill out all of the fields."

Scenario: Student tries to create an account with a preexisting uni
  When I go to student sign in page
  And I fill in 'Name?' with 'testing'
  And I fill in 'UNI?' with 'ab1234'
  And I fill in 'Password?' with 'pass'
  When I press "Create Student Account"
  Then I should see "An account with this UNI already exists. Please login instead. "

Scenario: Student creates an account
  When I go to student sign in page
  And I fill in 'Name?' with 'User User'
  And I fill in 'UNI?' with 'sk1234'
  And I fill in 'Password?' with 'pass'
  And I press "Create Student Account"
  Then I should see "Welcome User User!"
