Feature: Search
  In order to work with a set of documents
  As a kb editor
  I want to specify search criteria and retrieve matching documents

  @KMWL-6
  Scenario: Searches must have names
  Given I am on the search creation page
  When I fill in "search_name" with ""
  And I press "Create Search"
  Then I should see "Name can't be blank"
  And I should not see "The search was created successfully"

  Scenario: I can search for docs by id
  Given I am on the search creation page
  And a doc with id "aaaa"
  When I fill in "Docids" with "aaaa"
  And I press "Create Search"
  Then I should see "aaaa" within ".collection-section"