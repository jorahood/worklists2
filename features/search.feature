Feature: Search
  In order to work with a set of documents
  As a user creating a set of documents
  I want to specify search criteria and retrieve matching documents

    Scenario: Searches must have names
      Given I am editing a new unsaved search
      When I fill in "search_name" with ""
      And I press "Create Search"
      Then I should see "Name can't be blank"
      And I should not see "The search was created successfully"
