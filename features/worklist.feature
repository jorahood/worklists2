Feature: Worklist
  In order to work on a group of documents
  As a KB editor
  I want to create a list of documents

  Scenario: I can log in
  Given I am logged in as "Bob"
  Then I should see "Logged in as Bob"

  Scenario: A list should display the search it belongs to
  Given I am logged in as "Bob"
  And a user named "user_a"
  And a list named "Good list" owned by "user_a"
  And a search named "Good search"
  And list "Good list" belongs to search "Good search"
  When I view the list "Good list"
  Then I should see "Good search" in the body

  Scenario: A list should display the docs of the search it belongs to
  Given I am logged in as "Bob"
  And a user named "user_a"
  And a list named "Good list" owned by "user_a"
  And a search named "Good search"
  And a doc with id "aaaa"
  And search "Good search" returns doc "aaaa"
  And list "Good list" belongs to search "Good search"
  When I view the list "Good list"
  Then I should see "aaaa" within ".collection-section"

  Scenario: A list with a changed search should not display the docs from its old search
  Given I am logged in as "Bob"
  And a user named "user_a"
  And a list named "Good list" owned by "user_a"
  And a search named "Search for aaaa"
  And a doc with id "aaaa"
  And search "Search for aaaa" returns doc "aaaa"
  And list "Good list" belongs to search "Search for aaaa"
  And a search named "Search for bbbb"
  And a doc with id "bbbb"
  And search "Search for bbbb" returns doc "bbbb"
  When list "Good list" belongs to search "Search for bbbb"
  And I view the list "Good list"
  Then I should not see the word "aaaa" within ".collection-section"

  Scenario: A list should have a column to show notes for listed docs
  Given a user named "user_a"
  And a list named "Docs w/ notes" owned by "user_a"
  When I view the list "Docs w/ notes"
  Then I should see "Notes" within ".notes-heading"

  Scenario: A list should display notes belonging to its listed docs
  Given a user named "user_a"
  And a list named "Docs w/ notes" owned by "user_a"
  And a doc with id "aaaa"
  And a note with id 1 with text "hoochiemama"
  And doc "aaaa" has note 1 in list "Docs w/ notes"
  When I view the list "Docs w/ notes"
  Then I should see "hoochiemama" within ".notes-view"

  Scenario: For a valid user, a list should display a form for each listed doc to add a note.
  Given I am logged in as "Bob"
  And a user named "user_a"
  And a list named "Docs" owned by "user_a"
  And a doc with id "aaaa"
  And doc "aaaa" belongs to list "Docs"
  When I view the list "Docs"
  Then I should see element "form.new.note" within ".listed_doc"

  Scenario: The note forms should not display their doc associations; it should be set automatically.
  Given I am logged in as "Bob"
  And a user named "user_a"
  And a list named "Docs" owned by "user_a"
  And a doc with id "aaaa"
  And doc "aaaa" belongs to list "Docs"
  When I view the list "Docs"
  Then I should not see element "select.note-doc" within ".listed_doc"

  Scenario: The list should automatically set the note's associated doc to the listed_doc's doc.
  Given I am logged in as "Bob"
  And a user named "user_a"
  And a list named "Docs" owned by "user_a"
  And a doc with id "aaaa"
  And doc "aaaa" belongs to list "Docs"
  When I view the list "Docs"
  And I press "Add note"
  Then I should see "aaaa" within ".doc-view"

  Scenario: For a guest user, lists should not display a form for each listed doc to add a note.
  Given I am not logged in
  And a user named "user_a"
  And a list named "Docs" owned by "user_a"
  And a doc with id "aaaa"
  And doc "aaaa" belongs to list "Docs"
  When I view the list "Docs"
  Then I should not see element "form.new.note" within ".listed_doc"

  Scenario: For a valid user, a list with a search should display an input to refresh search results
  Given I am logged in as "Bob"
  And a user named "user_a"
  And a list named "Docs" owned by "user_a"
  And a search named "Searchy"
  And list "Docs" belongs to search "Searchy"
  When I view the list "Docs"
  Then I should see element "input.refresh_search-button" within "form.button-to"

  Scenario: For a valid user, a list without a search should not display an input to refresh search results
  Given I am logged in as "Bob"
  And a user named "user_a"
  And a list named "Docs" owned by "user_a"
  When I view the list "Docs"
  Then I should not see element "form.refresh-search" within ".content-body"

  Scenario: For the list owner, clicking the "refresh search" button should rerun the list's search
  Given I am logged in as "Bob"
  And a list named "Docs" owned by "Bob"
  And a doc with id "aaaa"
  And a kbuser named "jthatche"
  And doc "aaaa" has author "jthatche"
  And a search named "Authored by julie"
  And search "Authored by julie" has author "jthatche"
  And list "Docs" belongs to search "Authored by julie"
  And I view the list "Docs"
  And I should see "aaaa" within ".collection-section"
  But I should not see "bbbb" within ".collection-section"
  And a doc with id "bbbb"
  And doc "bbbb" has author "jthatche"
  When I press "Refresh search results"
  Then I should see "aaaa" within ".collection-section"
  And I should see "bbbb" within ".collection-section"

  Scenario: A list should have inputs to select which doc metadata to display
  Given I am logged in as "Bob"
  And I am on the list creation page
  Then I should see the following options checked:
  | option|
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
  |option|
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

  Scenario: A new list should display only the default metadata columns
  Given I am logged in as "Bob"
  And a list named "Docs" owned by "Bob"
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

  Scenario: A list's showable doc metadata should all correspond to actual attributes and associations of the doc
  Given I am logged in as "Bob"
  And a list named "Docs" owned by "Bob"
  And a doc with id "aaaa"
  And doc "aaaa" belongs to list "Docs"
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

  Scenario: A list should display only the metadata I pick plus 'docid' and the boilers heading should say boiler name
  Given I am logged in as "Bob"
  And a list named "Docs" owned by "Bob"
  When I edit the list "Docs"
  And I check "list_show_boilers"
  And I check "list_show_xtras"
  And I uncheck "list_show_visibility"
  And I press "Save"
  Then I should see element "th.boilers-heading" within "tr.field-heading-row"
  And I should see "Boiler Name" within "tr.field-heading-row"
  And I should see element "th.xtras-heading" within "tr.field-heading-row"
  And I should see element "th.docid-heading" within "tr.field-heading-row"
  But I should not see element "th.visibility-heading" within "tr.field-heading-row"
