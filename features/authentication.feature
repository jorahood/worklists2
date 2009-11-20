Feature: Authentication
  In order to protect the site from outsiders
  As an IU user
  I want to use CAS for authentication

  @production_rails_env
  Scenario: All users have to authenticate through CAS
  Given Worklists2 is in a production environment
  When I go to the homepage
  Then I should first have to log into CAS

  Scenario: CAS should be bypassed while testing
  When I go to the homepage
  Then I should not have to log into CAS first

  @production_rails_env
  Scenario: Paprika can bypass CAS
  Given I am Paprika
  And Worklists2 is in a production environment
  When I go to the homepage
  Then I should not have to log into CAS first

  Scenario: New users should not be logged in automatically with their CAS username
  Given I am logged into CAS as "bob" and go to the homepage
  Then I should not see "Logged in as bob" within ".account-nav"

  Scenario: Existing users should be logged in automatically with their CAS username
  Given a kbuser named "bob"
  When I am logged into CAS as "bob" and go to the homepage
  Then I should see "Logged in as bob" within ".account-nav"