Feature: manage profile as a student

    As a student
    I want to add tags to my profile and modify my schedule

Background: 
  Given a valid student user
  And I am on the sign in page
  And the following events exist:
    | name                   | datetime    | location    | description | tags |
    | pumpkin carving        | 31-Oct-2022 | East Campus | Fun!        | Freshman, STEM |
    | movie night            | 30-Oct-2022 | Lerner      | Marvel marathon | Junior, Humanities, Free Food |
  And the following events are on my events list:
    | name                   | datetime    | location    | description     | tags |
    | movie night            | 30-Oct-2022 | Lerner      | Marvel marathon | popcorn |
  And I fill in 'Name' with 'CucumberTestStudent'
  And I fill in 'UNI' with 'ab1234'
  And I fill in 'Password' with 'pass'
  And I press "Student Login"
  Then I am on event page
  When I press "My Profile"
  Then I should go to my profile page

Scenario: Modify profile tags 
    When I check the following tags: Freshman,STEM
    And I uncheck the following tags: Sophomore,Junior,Senior,Humanities
    When I press "Update Student Info" 
    Then I should see "You successfully updated your profile."

Scenario: View and update schedule
    When I follow "View Schedule"
    Then I should go to my schedule page
    When I follow "Edit Schedule"
    Then I should go to edit schedule page
    Given I am on edit schedule page
    When I select "Monday" from "Day"
    And I select time "01 AM:15" from "timeblock_busy_start"
    And I select time "02 AM:15" from "timeblock_busy_end"
    And I press "Add"
    When I select "Tuesday" from "Day"
    And I select time "01 AM:15" from "timeblock_busy_start"
    And I select time "02 AM:15" from "timeblock_busy_end"
    And I press "Add"
    When I select "Wednesday" from "Day"
    And I select time "01 AM:15" from "timeblock_busy_start"
    And I select time "02 AM:15" from "timeblock_busy_end"
    And I press "Add"
    When I select "Thursday" from "Day"
    And I select time "01 AM:15" from "timeblock_busy_start"
    And I select time "02 AM:15" from "timeblock_busy_end"
    And I press "Add"
    When I select "Friday" from "Day"
    And I select time "01 AM:15" from "timeblock_busy_start"
    And I select time "02 AM:15" from "timeblock_busy_end"
    And I press "Add"
    When I select "Saturday" from "Day"
    And I select time "01 AM:15" from "timeblock_busy_start"
    And I select time "02 AM:15" from "timeblock_busy_end"
    And I press "Add"
    When I select "Sunday" from "Day"
    And I select time "01 AM:15" from "timeblock_busy_start"
    And I select time "02 AM:15" from "timeblock_busy_end"
    And I press "Add"
    
    Then I should see "Schedule was successfully updated."

    





    

