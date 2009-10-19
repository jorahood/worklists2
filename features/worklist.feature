Feature: Worklist
  In order to work on a group of documents
  As a KB editor
  I want to create a list of documents

  Scenario: I can log in
  Given I am logged in as "Bob"
  Then I should see "Logged in as Bob"

  Scenario: A list will display the search it belongs to
  Given I am logged in as "Bob"
  And a user named "user_a"
  And a list named "Good list" owned by "user_a"
  And a search named "Good search"
  And list "Good list" belongs to search "Good search"

  When I view the worklist "Good list"

  Then I should see "Good search"

  Scenario: Assigning a search to a list assigns that search's docs to the list
  Given I am logged in as "Bob"
  And a user named "user_a"
  And a list named "Good list" owned by "user_a"
  And a search named "Good search"
  And a doc with id "abba"
  And search "Good search" includes doc "abba"

  When I edit the worklist "Good list"
