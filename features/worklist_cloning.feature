Feature: Worklist cloning
  In order to transition from worklists1
  As a KB editor
  I want to see clones of all v1 worklists in worklists2

  Scenario: It has a labelled input for a Worklists1 id to clone
  Given I am logged in as Bob
  And I am on the list creation page
  Then I should see element "input.list-wl1-clone"
  And I should see "Clone v1 Worklist" within "table.field-list"

  Scenario: It clones the comments, docids, categories (ie., tags), workstates, and notes of the v1 Worklist id entered
  Given I am logged in as Bob
  And I am on the list creation page
  And a doc with id arxq
  And a doc with id apev
  And a doc with id avck
  And a doc with id awfj
  When I fill in "list_name" with "test"
  When I fill in "list_wl1_clone" with "11777"
  And I press "Create List"
  Then I should see "arxq" within ".collection-section"
  And I should see "apev" within ".collection-section"
  And I should see "avck" within ".collection-section"
  And I should see "awfj" within ".collection-section"
  And I should see "test comments for 11777" within ".list-comment"
  And I should see "testcategory4"
  And I should see "test editor note for apev"
  And I should see "test owner note for arxq"
  And I should see "pending"
  And I should see "completed"
  And I should see "untouched"

  Scenario: There can be only one clone of a given v1 list
  Given I am logged in as Bob
  And a list named "test"
  And list "test" is a clone of 11777
  When I am on the list creation page
  And I fill in "list_wl1_clone" with "11777"
  And I press "Create List"
  Then I should not see "The list was created successfully"
  And I should see "A clone of list 11777 already exists"