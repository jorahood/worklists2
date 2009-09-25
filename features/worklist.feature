Feature: Worklist
  In order to work on a group of documents
  As a KB editor
  I want to create a list of documents

  Scenario: Save a search as a list
  Given I am editing a search
  When I press "Save as List"
  Then I should see "Worklist"
