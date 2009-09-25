Feature: CAS
  In order to protect the site from outsiders
  As an IU user
  I want to use CAS for authentication

  Scenario: All users have to authenticate through CAS
  Given Worklists2 is in a production environment
  When I go to the homepage
  Then I should be redirected to "https://cas.iu.edu/cas/login?cassvc=ANY&casurl=http://www.example.com/"
  And Worklists2 should be reset to a testing environment

  Scenario: CAS should be bypassed while testing
  When I go to the homepage
  Then I should not be redirected

  Scenario: Paprika can bypass CAS
  Given I am Paprika
  And Worklists2 is in a production environment
  When I go to the homepage
  Then I should not be redirected
  And Worklists2 should be reset to a testing environment
