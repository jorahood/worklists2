Feature: Viewing a listed doc

  Scenario: Each listed doc has a link to open it in the RCS web tool
    Given I am logged in as Bob
    And a doc with id arxq
    And a list named "rcs url test" created by Bob
    And doc arxq belongs to list "rcs url test"
    When I view the list "rcs url test"
    Then I should see element "a[href='https://bell.ucs.indiana.edu/~jorahood/rcsweb.cgi?docid=arxq&action=rlog']"

  Scenario: There is a link to the doc show page
    Given I am logged in as Bob
    And a doc with id arxq
    And a list named "doc show url test" created by Bob
    And doc arxq belongs to list "doc show url test"
    When I view the list "doc show url test"
    Then I should see element "a[href='/docs/arxq']"

  Scenario: Each listed doc uses the custom_url value to create the docid links for a list
    Given I am logged in as Bob
    And a doc with id arxq
    And a list named "custom url test" created by Bob
    And doc arxq belongs to list "custom url test"
    When I edit the list "custom url test"
    And I fill in "list_custom_url" with "http://test.com/%k.html"
    And I press "Save"
    Then I should see element "a[href='http://test.com/arxq.html']"

  Scenario: The default url for docid links is the workshop
    Given I am logged in as Bob
    And a doc with id arxq
    And a list named "default url test" created by Bob
    And doc arxq belongs to list "default url test"
    When I edit the list "default url test"
    And I fill in "list_custom_url" with ""
    And I press "Save"
    Then I should see element "a[href='https://bell.ucs.indiana.edu/workshop/workshop.cgi?id=arxq&openDoc=Open+document+ID&rm=documentDisplaySimple']"

  Scenario: docid links open in a new window
    Given I am logged in as Bob
    And a doc with id arxq
    And a list named "new window test" created by Bob
    And doc arxq belongs to list "new window test"
    When I view the list "new window test"
    Then I should see element "a[target='arxq-ws']"
    And I should see element "a[target='arxq-rcs']"
    And I should see element "a[target='arxq-show']"

  Scenario: It displays only the metadata I pick plus 'docid', customizes column names, and empty has_many collections don't say "(none)"
    Given I am logged in as Bob
    And a list named "Docs" created by Bob
    And a doc with id aaaa
    And doc aaaa belongs to list "Docs"
    When I edit the list "Docs"
    And I check "list_show_boilers"
    And I check "list_show_workshop_wfinodes"
    And I check "list_show_xtras"
    And I uncheck "list_show_visibility"
    And I press "Save"
    Then I should see "Boiler Name" within "tr.field-heading-row"
    Then I should see "Workshop Desk" within "tr.field-heading-row"
    And I should see "Xtras" within "tr.field-heading-row"
    And I should see "Docid" within "tr.field-heading-row"
    But I should not see "Visibility" within "tr.field-heading-row"
    And I should not see "(none)"

  Scenario: The Workshop Desk column has a link to the workshop desk that opens in a new window
    Given a kbuser exists with username: "jorahood"
    And I am logged into CAS as jorahood
    And a list exists with name: "Docs", creator: the kbuser, show_workshop_wfinodes: true
    And a doc exists with id: "aaaa"
    And a workshop_wfinode exists with desk: 258, owner: "joebob"
    And a workshop_document_asset exists with doc: the doc, workshop_wfinode: the workshop_wfinode
    #FIXME: refactor the below step using pickle's regexs as And the doc belongs to the list
    And doc aaaa belongs to list "Docs"
    When I go to the list's page
    Then I should see "joebob" within "a[href='https://bell.ucs.indiana.edu/workshop/workshop.cgi?rm=userPageSimple&id=258'][target='joebob-wsdesk']"
