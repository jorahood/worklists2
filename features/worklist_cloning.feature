Feature: Worklist cloning
  In order to transition from worklists1
  As a KB editor
  I want to see clones of all v1 worklists in worklists2

  Scenario: It has a labelled input for a Worklists1 id to clone
    Given I am logged in as Bob
    And I am on the list creation page
    Then I should see element "input.list-wl1-clone"
    And I should see "Clone v1 Worklist" within "table.field-list"

  Scenario: It clones all v1 Worklist data
    Given I am logged in as Bob
    And I am on the list creation page
    And a doc with id arxq
    And a doc with id apev
    And a doc with id avck
    And a doc with id awfj
    When I fill in "list_name" with "test"
    When I fill in "list_wl1_clone" with "11777"
    And I press "Create List"
    And I view the list "Windows 7 - storage"
    Then I should see "arxq" within ".collection-section"
    And I should see "apev" within ".collection-section"
    And I should see "avck" within ".collection-section"
    And I should see "awfj" within ".collection-section"
    And I should see "test comments for 11777"
    And I should see "testcategory4"
    And I should see "test editor note for apev"
    And I should see "test owner note for arxq"
    And I should see element "option[selected='selected'][value='pending']"
    And I should see element "option[selected='selected'][value='completed']"
    And I should see element "option[selected='selected'][value='untouched']"

  Scenario: There can be only one clone of a given v1 list
    Given I am logged in as Bob
    And a list named "test"
    And list "test" is a clone of 11777
    When I am on the list creation page
    And I fill in "list_wl1_clone" with "11777"
    And I press "Create List"
    Then I should not see "The list was created successfully"
    And I should see "That list has already been cloned"
