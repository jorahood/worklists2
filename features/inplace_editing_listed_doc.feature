Feature: Editing listed docs in the List show table view

  Scenario: I can edit the workstate
    Given I am logged in as Bob
    * a doc with id aroo
    * a list named "editing workstate" created by Bob
    * doc aroo belongs to list "editing workstate"
    When I view the list "editing workstate"
    Then I select "Pending" from "workstate"
