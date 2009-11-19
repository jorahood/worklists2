Feature: User
  In order to work with others
  As a worklists2 user
  I want to log in

  Scenario: New users should not be logged in automatically with their CAS username
  Given I am logged into CAS as "bob" and go to the homepage
  Then I should not see "Logged in as bob" within ".account-nav"

  Scenario: Existing users should be logged in automatically with their CAS username
  Given a user named "bob"
  And I am logged into CAS as "bob" and go to the homepage
  Then I should see "Logged in as bob" within ".account-nav"

