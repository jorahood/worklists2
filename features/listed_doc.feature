Feature: Viewing a listed doc

  Scenario: Each listed doc has a link to open it in the RCS web tool
  Given I am logged in as Bob
  And a doc with id arxq
  And a list named "rcs url test" created by Bob
  And doc arxq belongs to list "rcs url test"
  When I view the list "rcs url test"
  Then I should see element "a[href='https://bell.ucs.indiana.edu/~jorahood/rcsweb.cgi?docid=arxq&action=rlog']"

  Scenario: Each listed doc  uses the custom url to create the docid links for a list
  Given I am logged in as Bob
  And a doc with id arxq
  And a list named "custom url test" created by Bob
  And doc arxq belongs to list "custom url test"
  When I edit the list "custom url test"
  And I fill in "list_custom_url" with "http://test.com/%s.html"
  And I press "Save"
  Then I should see element "a[href='http://test.com/arxq.html']"

  Scenario: The default url for docid links is the workshop
  Given I am logged in as Bob
  And a doc with id arxq
  And a list named "default url test" created by Bob
  And doc arxq belongs to list "default url test"
  When I view the list "default url test"
  Then I should see element "a[href='https://bell.ucs.indiana.edu/workshop/workshop.cgi?id=arxq&openDoc=Open+document+ID&rm=documentDisplaySimple']"

  Scenario: links in the listed doc should open a new window
  Given I am logged in as Bob
  And a doc with id arxq
  And a list named "new window test" created by Bob
  And doc arxq belongs to list "new window test"
  When I view the list "new window test"
  Then I should see element "a[target='arxq-view']"
  And I should see element "a[target='arxq-rcs']"
