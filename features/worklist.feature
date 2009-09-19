Feature: Worklist
  In order to work on a group of documents as a group
  As a KB editor
  I want to be able to create lists of documents

  Scenario: Save a search as a list
    Given a search
    When I save the search as a list
    Then a new list should be created
    And the new list should belong to the search
