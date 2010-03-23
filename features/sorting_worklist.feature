@javascript
Feature: Sorting worklists

  Scenario: I can sort on modified date
  Given I am logged in as Bob
  And the following docs exist:
  |docid|modifieddate|
  |aaaa|2010-01-01|
  |cccc|2030-03-03|
  |bbbb|2020-02-02|
  And a list named "sorting modifieddate test" created by Bob
  And doc aaaa belongs to list "sorting modifieddate test"
  And doc cccc belongs to list "sorting modifieddate test"
  And doc bbbb belongs to list "sorting modifieddate test"
  When I view the list "sorting modifieddate test"
  And I follow "Modifieddate"
  Then I should see <text> in "tr.listed_doc" in the following order, starting with 1:
  |text|
  |aaaa|
  |bbbb|
  |cccc|
  And I follow "Modifieddate"
  Then I should see <text> in "tr.listed_doc" in the following order, starting with 1:
  |text|
  |cccc|
  |bbbb|
  |aaaa|

Scenario: I can sort on Workstate
  Given I am logged in as Bob
  And the following docs exist:
  |docid|
  |pend|
  |untc|
  |comp|
  And a list named "sorting workstate test" created by Bob
  And doc pend belongs to list "sorting workstate test" with workstate "pending"
  And doc untc belongs to list "sorting workstate test" with workstate "untouched"
  And doc comp belongs to list "sorting workstate test" with workstate "completed"
  When I view the list "sorting workstate test"
  And I follow "Workstate"
  Then I should see <text> in "tr.listed_doc" in the following order, starting with 1:
  |text|
  |comp|
  |pend|
  |untc|
  And I follow "Workstate"
  Then I should see <text> in "tr.listed_doc" in the following order, starting with 1:
  |text|
  |untc|
  |pend|
  |comp|
