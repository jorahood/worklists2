Feature: Search
    In order to work with a set of documents
    As a user creating a set of documents
    I want to specify search criteria and retrieve matching documents

    Scenario: Searches have to be named
      Given I am editing a new unsaved search
      When it has no name
      Then saving it should give me a validation error that says "name is required"
