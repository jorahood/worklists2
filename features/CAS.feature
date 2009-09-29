Feature: CAS
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
