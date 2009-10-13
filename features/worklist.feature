Feature: Worklist
  In order to work on a group of documents
  As a KB editor
  I want to create a list of documents

  Scenario: Selecting a search for a list

  Given a user named "user_a"
  And a list named "Good list" owned by "user_a"
  And a search named "Good search"

  When I edit the worklist "Good list"
  And I select "Good search" from "list[search_id]"
  And I press "Save"

  Then I should see /Search\s*Good search/ spanning multiple lines

  Scenario: Assigning a search to a list assigns that search's docs to the list

  Given a user named "user_a"
  And a list named "Good list" owned by "user_a"
  And a search named "Good search"
  And a doc with id "abba"
  And search "Good search" includes doc "abba"

  When I edit the worklist "Good list"
  And I select "Good search" from "list[search_id]"
  And I press "Save"

  Then I should see "abba"
