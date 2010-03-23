Feature: Worklist
  In order to work on a group of documents
  As a KB editor
  I want to create a list of documents

  Scenario: Worklists will automatically name themselves
  Given I am logged in as Bob
  And I am on the list creation page
  When I press "Create List"
  Then I should not see "Name can't be blank"
  And I should see "whatevs, can't be bothered to name my list"

  Scenario: It displays the total number of listed docs
  Given a kbuser named user_a
  And a list named "Docs" created by user_a
  And a doc with id aaaa
  And a doc with id bbbb
  And doc aaaa belongs to list "Docs"
  And doc bbbb belongs to list "Docs"
  When I view the list "Docs"
  Then I should see /^\s*2 Listed Docs\s*$/ within ".collection-heading"

  Scenario: It displays the search it belongs to
  Given I am logged in as Bob
  And a kbuser named user_a
  And a list named "Good list" created by user_a
  And a search named "Good search"
  And list "Good list" belongs to search "Good search"
  When I view the list "Good list"
  Then I should see "Good search"

  Scenario: It displays a "Refresh search results" button if you are logged in
  Given I am logged in as Bob
  And a list named "Good list" created by Bob
  And a search named "Good search"
  And list "Good list" belongs to search "Good search"
  When I view the list "Good list"
  Then I should see element "input.refresh_search-button"

  Scenario: It does not display a "Refresh search results" button if you are not logged in
  Given a kbuser named user_a
  And a list named "Good list" created by user_a
  And a search named "Good search"
  And list "Good list" belongs to search "Good search"
  When I view the list "Good list"
  Then I should not see element "input.refresh_search-button"

  Scenario: It displays the docs of the search it belongs to
  Given I am logged in as Bob
  And a kbuser named user_a
  And a list named "Good list" created by user_a
  And a search named "Good search"
  And a doc with id aaaa
  And search "Good search" returns doc aaaa
  And list "Good list" belongs to search "Good search"
  When I view the list "Good list"
  Then I should see "aaaa" within ".collection-section"

  Scenario: With a changed search, it does not display the docs from its old search
  Given I am logged in as Bob
  And a kbuser named user_a
  And a list named "Good list" created by user_a
  And a search named "Search for aaaa"
  And a doc with id aaaa
  And search "Search for aaaa" returns doc aaaa
  And list "Good list" belongs to search "Search for aaaa"
  And a search named "Search for bbbb"
  And a doc with id bbbb
  And search "Search for bbbb" returns doc bbbb
  When list "Good list" belongs to search "Search for bbbb"
  And I view the list "Good list"
  Then I should not see the word "aaaa" within ".collection-section"

  Scenario: Has a column to show notes for listed docs
  Given a kbuser named user_a
  And a list named "Docs w/ notes" created by user_a
  And a doc with id aaaa
  And doc aaaa belongs to list "Docs w/ notes"
  When I view the list "Docs w/ notes"
  Then I should see "Notes" within ".notes-heading"

  Scenario: Display notes belonging to its listed docs
  Given a kbuser named user_a
  And a list named "Docs w/ notes" created by user_a
  And a doc with id aaaa
  And a note with id 1 with text "hoochiemama"
  And doc aaaa has note 1 in list "Docs w/ notes"
  When I view the list "Docs w/ notes"
  Then I should see "hoochiemama" within ".notes-view"

  Scenario: For a valid user, it displays a form for each listed doc to add a note.
  Given I am logged in as Bob
  And a kbuser named user_a
  And a list named "Docs" created by user_a
  And a doc with id aaaa
  And doc aaaa belongs to list "Docs"
  When I view the list "Docs"
  Then I should see element "form.new.note"

  Scenario: The note forms do not display their doc associations.
  Given I am logged in as Bob
  And a kbuser named user_a
  And a list named "Docs" created by user_a
  And a doc with id aaaa
  And doc aaaa belongs to list "Docs"
  When I view the list "Docs"
  Then I should not see element "select.note-doc"

  Scenario: It automatically sets the note's associated doc to the listed_doc's doc.
  Given I am logged in as Bob
  And a kbuser named user_a
  And a list named "Docs" created by user_a
  And a doc with id aaaa
  And doc aaaa belongs to list "Docs"
  When I view the list "Docs"
  And I press "Add note"
  Then I should see "aaaa" within ".doc-view"

  Scenario: For a guest user, it does not display a form for each listed doc to add a note.
  Given I am not logged in
  And a kbuser named user_a
  And a list named "Docs" created by user_a
  And a doc with id aaaa
  And doc aaaa belongs to list "Docs"
  When I view the list "Docs"
  Then I should not see element "form.new.note"

  Scenario: For a valid user, a list with a search displays an input to refresh search results
  Given I am logged in as Bob
  And a kbuser named user_a
  And a list named "Docs" created by user_a
  And a search named "Searchy"
  And list "Docs" belongs to search "Searchy"
  When I view the list "Docs"
  Then I should see element "input.refresh_search-button"

  Scenario: For a valid user, a list without a search does not display an input to refresh search results
  Given I am logged in as Bob
  And a kbuser named user_a
  And a list named "Docs" created by user_a
  When I view the list "Docs"
  Then I should not see element "form.refresh-search"

  Scenario: For the list owner, clicking the "refresh search" button reruns the list's search
  Given I am logged in as Bob
  And a list named "Docs" created by Bob
  And a doc with id aaaa
  And a kbuser named jthatche
  And doc aaaa has author jthatche
  And a search named "Authored by julie"
  And search "Authored by julie" has author jthatche
  And list "Docs" belongs to search "Authored by julie"
  And I view the list "Docs"
  And I should see "aaaa" within ".collection-section"
  But I should not see "bbbb" within ".collection-section"
  And a doc with id bbbb
  And doc bbbb has author jthatche
  When I press "Refresh search results"
  Then I should see "aaaa" within ".collection-section"
  And I should see "bbbb" within ".collection-section"

  Scenario: It has inputs to select which doc metadata to display
  Given I am logged in as Bob
  And I am on the list creation page
  Then I should see the following options checked:
  | option |
  | approveddate |
  | domains |
  | modifieddate |
  | notes |
  | owner |
  | tags |
  | titles |
  | visibility |
  | workstate |

  And I should see the following options unchecked:
  | option |
  | author |
  | boilers |
  | birthdate |
  | expirations |
  | hotitems |
  | importance |
  | kbas |
  | kba_bys |
  | refs |
  | refbys |
  | referenced_boilers |
  | resources |
  | status |
  | volatility |
  | xtras |

  And I should see "Show Boiler Name" within ".show-boilers-label"
  And I should not see "Show Docid" within "form.new"

  Scenario: A new list displays only the default metadata columns
  Given I am logged in as Bob
  And a list named "Docs" created by Bob
  And a doc with id aaaa
  And doc aaaa belongs to list "Docs"
  When I view the list "Docs"
  Then I should see the following headings:
  |heading|
  | docid |
  | approveddate |
  | domains |
  | modifieddate |
  | notes |
  | owner |
  | tags |
  | titles |
  | visibility |
  | workstate |

  And I should not see any other headings

  Scenario: Showable doc metadata all correspond to actual attributes and associations of the doc
  Given I am logged in as Bob
  And a list named "Docs" created by Bob
  And a doc with id aaaa
  And doc aaaa belongs to list "Docs"
  When I edit the list "Docs"
  And I check the following boxes:
  |checkbox|
  | approveddate |
  | domains |
  | modifieddate |
  | notes |
  | owner |
  | tags |
  | titles |
  | visibility |
  | workstate |
  | author |
  | boilers |
  | birthdate |
  | expirations |
  | hotitems |
  | importance |
  | kbas |
  | kba_bys |
  | refs |
  | refbys |
  | referenced_boilers |
  | resources |
  | status |
  | volatility |
  | xtras |

  And I press "Save"
  Then I should see the following headings:
  |heading|
  |docid|
  | approveddate |
  | domains |
  | modifieddate |
  | notes |
  | owner |
  | tags |
  | titles |
  | visibility |
  | workstate |
  | author |
  | boilers |
  | birthdate |
  | expirations |
  | hotitems |
  | importance |
  | kbas |
  | kba-bys |
  | refs |
  | refbys |
  | referenced-boilers |
  | resources |
  | status |
  | volatility |
  | xtras |

  Scenario: Checkboxes for showable metadata appear in the same order as worklists1
  Given I am logged in as Bob
  When I go to the list creation page
  Then I should see <text> in "tr" in the following order, starting with 3:
  | text |
  | Show Titles |
  | Show Approveddate |
  | Show Modifieddate |
  | Show Birthdate |
  | Show Domains |
  | Show Owner |
  | Show Author |
  | Show Refs |
  | Show Refbys |
  | Show Boiler Name |
  | Show Referenced Boilers |
  | Show Expirations |
  | Show Hotitems |
  | Show Importance |
  | Show Resources |
  | Show Status |
  | Show Visibility |
  | Show Volatility |
  | Show Kbas |
  | Show Kba Bys |
  | Show Xtras |
  | Show Tags |
  | Show Notes |
  | Show Workstate |

  Scenario: It displays only the metadata I pick plus 'docid' and the boilers heading should say boiler name
  Given I am logged in as Bob
  And a list named "Docs" created by Bob
  And a doc with id aaaa
  And doc aaaa belongs to list "Docs"
  When I edit the list "Docs"
  And I check "list_show_boilers"
  And I check "list_show_xtras"
  And I uncheck "list_show_visibility"
  And I press "Save"
  Then I should see "Boiler Name" within "tr.field-heading-row"
  And I should see "Xtras" within "tr.field-heading-row"
  And I should see "Docid" within "tr.field-heading-row"
  But I should not see "Visibility" within "tr.field-heading-row"

  Scenario: It has a labelled input for a Worklists1 id to import
  Given I am logged in as Bob
  And I am on the list creation page
  Then I should see element "input.list-wl1-import"
  And I should see "Import v1 Worklist" within "table.field-list"

  Scenario: It imports the docids of the v1 Worklist id entered
  Given I am logged in as Bob
  And I am on the list creation page
  And a doc with id arxq
  And a doc with id apev
  And a doc with id avck
  And a doc with id awfj
  When I fill in "list_name" with "test"
  When I fill in "list_wl1_import" with "11777"
  And I press "Create List"
  Then I should see "arxq" within ".collection-section"
  And I should see "apev" within ".collection-section"
  And I should see "avck" within ".collection-section"
  And I should see "awfj" within ".collection-section"

  Scenario: It has a labelled input for the custom url to use for docid links
  Given I am logged in as Bob
  When I am on the list creation page
  Then I should see "Custom URL" within "table.field-list"

