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

  When I view the list "Good list"

  Then I should see "Good search" in the body

  Scenario: A list will display the docs of the search it belongs to
  Given I am logged in as "Bob"
  And a user named "user_a"
  And a list named "Good list" owned by "user_a"
  And a search named "Good search"
  And a doc with id "aaaa"
  And search "Good search" returns doc "aaaa"
  And list "Good list" belongs to search "Good search"

  When I view the list "Good list"

  Then I should see "aaaa" in the body

  Scenario: A list will not display the docs of a search it no longer belongs to
  Given I am logged in as "Bob"
  And a user named "user_a"
  And a list named "Good list" owned by "user_a"
  And a search named "Good search"
  And a doc with id "aaaa"
  And search "Good search" returns doc "aaaa"
  And list "Good list" belongs to search "Good search"

  When I remove the search assigned to list "Good list"
  And I view the list "Good list"

  Then I should not see "aaaa" in the body

  Scenario: A list will have a column to show notes for listed docs
  Given a user named "user_a"
  And a list named "Docs w/ notes" owned by "user_a"

  Then I should see "Notes" within "th.notes-heading"

  Scenario: A list will display notes belonging to its listed docs
  Given I am logged in as "Bob"
  And a user named "user_a"
  And a list named "Docs w/ notes" owned by "user_a"
  And a doc with id "aaaa"
  And a note with id 1 with text "hoochiemama"
  And doc "aaaa" has note 1 in list "Docs w/ notes"

  When I view the list "Docs w/ notes"

  Then I should see "hoochiemama" within ".notes-view"
  