 Feature: Authentication
  In order to protect the site from outsiders
  As an IU user
  I want to use CAS for authentication

  Scenario: I can log in
  Given I am logged in as Bob
  Then I should see "Logged in as Bob"

  @production_rails_env @culerity
  Scenario: All users have to authenticate through CAS
  Given Worklists2 is in a production environment
  When I go to the homepage
  Then I should first have to log into CAS

  Scenario: CAS should be bypassed while testing
  When I go to the homepage
  Then I should not have to log into CAS first

  @production_rails_env
  Scenario: Dolga can bypass CAS
  Given I am Dolga
  And Worklists2 is in a production environment
  When I go to the homepage
  Then I should not have to log into CAS first

  Scenario: People without kbuser accounts should not be logged in automatically with their CAS username
  Given I am logged into CAS as bob
  When I go to the homepage
  Then I should not see "Logged in as bob" within ".account-nav"

  Scenario: Existing users should be logged in automatically with their CAS username
  Given a kbuser named bob
  And I am logged into CAS as bob
  When I go to the homepage
  Then I should see "Logged in as bob" within ".account-nav"
