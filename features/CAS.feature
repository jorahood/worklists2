Feature: CAS
  In order to protect the site from outsiders
  As an IU user
  I want to have the site to use CAS for authentication

  Scenario: Unlogged in user
  Given I am not logged into CAS
  When I go to the homepage
  Then I should be redirected to "https://cas.iu.edu/cas/login?cassvc=ANY&casurl=http://www.example.com/"

