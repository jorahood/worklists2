Feature: Sorting worklists

  Scenario: I can sort on modified date
  Given I am logged in as Bob
  And the following docs exist:
  |docid|modifieddate|
  |arxq|2010-01-01|
  |abba|2020-02-02|
  And a list named "sorting modifieddate test" created by Bob
  And doc arxq belongs to list "sorting modifieddate test"
  And doc abba belongs to list "sorting modifieddate test"
  When I view the list "sorting modifieddate test"
  And I follow "Modifieddate"
  #repeat to sort descending
  And I follow "Modifieddate"
  Then I should see <text> in "tr.listed_doc" in the following order, starting with 1:
  |text|
  |February  2, 2020|
  |January  1, 2010|

Scenario: I can sort on Workstate
  Given I am logged in as Bob
  And the following docs exist:
  |docid|
  |arxq|
  |abba|
  |agoo|
  And a list named "sorting workstate test" created by Bob
  And doc arxq belongs to list "sorting workstate test" with workstate "pending"
  And doc abba belongs to list "sorting workstate test" with workstate "untouched"
  And doc agoo belongs to list "sorting workstate test" with workstate "completed"
  When I view the list "sorting workstate test"
  And I follow "Workstate"
  Then I should see <text> in "tr.listed_doc" in the following order, starting with 1:
  |text|
  |completed|
  |pending|
  |untouched|
