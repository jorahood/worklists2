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

  Scenario: I can select a docid to search on
  Given a doc with id "aaaa"
  And I am on the search creation page
  Then I should see "aaaa" within ".search-docids"

  Scenario: Searches will not return docs that don't match a docid search
  Given a doc with id "aaaa"
  And a doc with id "bbbb"
  And a search named "Search for aaaa"
  And doc "aaaa" belongs to search "Search for aaaa" through a docid search
  When I view the search "Search for aaaa"
  Then I should see "aaaa" within ".collection-section tbody"
  And I should not see "bbbb" within ".collection-section tbody"