Feature: log in as an organizer

  As an organizer
  I want to log in to my org events page

Background: 

  Given a valid organizer
  

Scenario: Organization signs in with correct credentials

  When I go to sign in page
  And I fill in 'Org Name' with 'CucumberTestUser'
  And I fill in 'Org Email' with 'ab@columbia.edu'
  And I fill in 'Org Password' with 'pass'
  When I press "Organization Login"
  Then I should be on org events page for "CucumberTestUser"
  And I should see "Welcome back CucumberTestUser!"
  
Scenario: Organization tries to sign in with incorrect password

  When I go to sign in page
  And I fill in 'Org Name' with 'CucumberTestUser'
  And I fill in 'Org Email' with 'ab@columbia.edu'
  And I fill in 'Org Password' with 'bla'
  When I press "Organization Login"
  Then I should see "Username or password incorrect. Please try again!"

Scenario: Organization tries to sign in with incorrect organization name

  When I go to sign in page
  And I fill in 'Org Name' with 'User'
  And I fill in 'Org Email' with 'ab@columbia.edu'
  And I fill in 'Org Password' with 'pass'
  And I press "Organization Login"
  Then I should see "Username or password incorrect. Please try again!"

Scenario: Organization tries to sign in with unknown email

  When I go to sign in page
  And I fill in 'Org Name' with 'CucumberTestUser'
  And I fill in 'Org Email' with 'test@columbia.edu'
  And I fill in 'Org Password' with 'pass'
  And I press "Organization Login"
  Then I should see "Organization not found-- please create an account!"


Scenario: Organization does not fill out all fields to create an account
  When I go to sign in page
  And I fill in 'Org Name?' with ''
  And I fill in 'Org Email?' with 'ab@columbia.edu'
  And I fill in 'Org Password?' with 'bla'
  When I press "Create Organizer Account"
  Then I should see "Please fill out all of the fields."

Scenario: Organization tries to create an account with a preexisting email
  When I go to sign in page
  And I fill in 'Org Name?' with 'testing'
  And I fill in 'Org Email?' with 'ab@columbia.edu'
  And I fill in 'Org Password?' with 'pass'
  When I press "Create Organizer Account"
  Then I should see "An account with this UNI already exists. Please login instead. "

Scenario: Organization creates an account
  When I go to sign in page
  And I fill in 'Org Name?' with 'User User'
  And I fill in 'Org Email?' with 'sedrft@columbia.edu'
  And I fill in 'Org Password?' with 'pass'
  And I press "Create Organizer Account"
  Then I should be on org events page for "User User"
  And I should see "Welcome User User!"

Scenario: Organization logs out
  Given I am on org events page for "CucumberTestUser"
  When I follow "Logout"
  Then I should be on sign in page