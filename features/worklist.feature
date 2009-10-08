Feature: Worklist
  In order to work on a group of documents
  As a KB editor
  I want to create a list of documents

  Scenario: Selecting a search for a list
  Given a list named "Good list"
  And a search named "Good docs"
  When I edit the worklist "Good List"
  And I select "Good docs" from "list[search_id]"
  And I press "Save"
  Then I should see /Search\s*Good docs/ spanning multiple lines
