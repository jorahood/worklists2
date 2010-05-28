Feature: notes

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
    And I view the list "Docs"
    When I press "Add note"
    Then I should see "aaaa" within ".doc-view"

  @javascript
  Scenario: It automatically sets the note's creator to the acting user
    Given I am logged in as me
    And a list named "Docs" created by me
    And a doc with id aaaa
    And doc aaaa belongs to list "Docs"
    And I view the list "Docs"
    When I fill in "note_text" with "hiya"
    And press "Add note"
    Then I should see "me" within ".card.note .creator-link"

  Scenario: For a guest user, it does not display a form for each listed doc to add a note.
    Given I am not logged in
    And a kbuser named user_a
    And a list named "Docs" created by user_a
    And a doc with id aaaa
    And doc aaaa belongs to list "Docs"
    When I view the list "Docs"
    Then I should not see element "form.new.note"

  Scenario: Don't show notes from earlier appearances of a doc in a list
    Given I am logged in as Bob
    And a list named "first" created by Bob
    And a doc with id aaaa
    And a note with id 1 with text "hoochiemama"
    And doc aaaa has note 1 in list "first"
    And a list named "second" created by Bob
    And doc aaaa belongs to list "second"
    When I view the list "second"
    Then I should not see "hoochiemama" within ".notes-view"

  Scenario: Show all notes for a doc on the doc show page
    Given I am logged in as Bob
    And a doc with id aaaa
    And a list named "first" created by Bob
    And a note with id 1 with text "hoochiemama"
    And doc aaaa has note 1 in list "first"
    And a list named "second" created by Bob
    And a note with id 2 with text "woowoowoo"
    And doc aaaa has note 2 in list "second"
    When I view the doc aaaa
    Then I should see "hoochiemama"
    And I should see "woowoowoo"

  @javascript
  Scenario: Users can delete their own notes
    Given I am logged in as me
    And a list named "Docs w/ notes" created by me
    And a doc with id aaaa
    And a note with id 1 with text "hoochiemama" created by me
    And doc aaaa has note 1 in list "Docs w/ notes"
    And I view the list "Docs w/ notes"
    When I press the delete button
    Then I should not see "hoochiemama"

  Scenario: There is no delete button displayed for other users' notes
    Given I am logged in as me
    And a kbuser named you
    And a list named "Docs w/ notes" created by me
    And a doc with id aaaa
    And a note with id 1 with text "hoochiemama" created by you
    And doc aaaa has note 1 in list "Docs w/ notes"
    And I view the list "Docs w/ notes"
    Then I should not see element ".delete-note-button"

  Scenario: There is an in-place editor for notes in lists
    Given I am logged in as me
    And a list named "Docs w/ notes" created by me
    And a doc with id aaaa
    And a note with id 1 with text "hoochiemama" created by me
    And doc aaaa has note 1 in list "Docs w/ notes"
    When I view the list "Docs w/ notes"
    Then I should see "hoochiemama" within "div.note-text.in-place-edit"

  Scenario: The note show page has a link to the note's list
    Given I am logged in as me
    And a list named "Link to list" created by me
    And a doc with id aaaa
    And a note with id 1 with text "hoochiemama" created by me
    And doc aaaa has note 1 in list "Link to list"
    And I view note 1
    Then I should see "Link to list" within "a.parent-link"

  Scenario: The note show page displays the note's id
    Given I am logged in as me
    And a note exists with id: "123"
    When I go to the note's page
    Then I should see "123"

  Scenario: In a listed doc, a note displays its id number
    Given I am logged in as me
    And a list named "blah" created by me
    And a doc exists with id: "aaaa"
    And a note with id 123 with text "hoochiemama" created by me
    And doc aaaa has note 123 in list "blah"
    When I view the list "blah"
    Then I should see "123"

  @javascript
  Scenario: Notes are collapsed by default and you click "Show" to expand
    Given a kbuser exists with username: "me"
    And I am logged into CAS as me
    And a list exists
    And a doc exists
    And a listed doc "ld" exists with doc: the doc, list: the list
    And a note exists with text: "I'm one", listed_doc: the listed doc
    And a note exists with text: "I'm two", listed_doc: the listed doc
    And a note exists with text: "I'm three", listed_doc: the listed doc
    When I go to the list's page
    And I follow "Show all 3 notes"
    Then I should see "Collapse notes"
