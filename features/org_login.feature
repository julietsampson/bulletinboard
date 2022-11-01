Feature: log in as an organizer

  As an organizer
  I want to log in to my org events page

Background: 

  Given a valid organizer
  

Scenario: Organization signs in with correct credentials

  When I go to sign in page
  And I fill in 'Org Name' with 'User User'
  And I fill in 'Email' with 'ab@columbia.edu'
  And I fill in 'Org Password' with 'pass'
  When I press "Organization Login"
  Then I should go to org events page
  
Scenario: Organization tries to sign in with incorrect password

  When I go to sign in page
  And I fill in 'Org Name' with 'CucumberTestUser'
  And I fill in 'Email' with 'ab@columbia.edu'
  And I fill in 'Org Password' with 'bla'
  When I press "Organization Login"
  Then I should see "Password incorrect. Please try again!"