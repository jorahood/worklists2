Given /^a kbuser named (.*)$/ do |name|
  user = Kbuser.new
  # We have to set the username after creating the new object because it is set
  # as the primary key because Rails will autogen a sequence integer for it and
  # drop the username if I tried to set it on create: Kbuser.create!(:username
  # => 'blah')
  user.username = name
  user.save!
end

Given /^a list named "([^\"]*)" created by (.*)$/ do |list_name, username|
  List.create!(:name => list_name, :creator => Kbuser.find_by_username(username))
end

Given /^a search named "([^\"]*)"$/ do |name|
  Search.create!(:name => name)
end

Given /^a list named "([^\"]*)"$/ do |name|
  Factory.create(:list, :name => name)
end

Given /^a doc with id ([a-z]{4})$/ do |docid|
  doc = Doc.new
  doc.id = docid
  doc.save!
end

Given /^search "([^\"]*)" returns doc ([a-z]{4})$/ do |search_name, docid|
  doc = Doc.find(docid)
  search = Search.find_by_name(search_name)
  search.docids << doc
  search.save!
end

Given /^list "([^\"]*)" belongs to search "([^\"]*)"$/ do |list_name, search_name|
  search = Search.find_by_name(search_name)
  list = List.find_by_name(list_name)
  list.search = search
  list.save!
end

Given /^a note with id (\d+) with text "([^\"]*)"$/ do |note_id, text|
  note = Note.new(:text => text)
  note.id = note_id
  note.save!
end

Given /^a note with id (\d+) with text "([^\"]*)" created by (.*)$/ do |note_id, text, username|
  note = Note.new(:text => text, :creator => Kbuser.find_by_username(username))
  note.id = note_id
  note.save!
end

#FIXME: need to refactor this and the with workstate step into a common, table-accepting step
# to create listed docs with attributes that will create the necessary docs on the fly. See if
# FactoryGirl can help creating the associated models automatically
Given /^doc ([a-z]{4}) has note (\d+) in list "([^\"]*)"$/ do |docid, note_id, list_name|
  doc = Doc.find(docid)
  note = Note.find(note_id)
  note.doc = doc
  note.save!
  list = List.find_by_name(list_name)
  doc_in_list = ListedDoc.new(:doc => doc, :list => list)
  doc_in_list.notes << note
  doc_in_list.save!
end

Given /^doc ([a-z]{4}) belongs to list "([^\"]*)"$/ do |docid, list_name|
  doc = Doc.find(docid)
  list = List.find_by_name(list_name)
  list.docs << doc
  list.save!
end

Given /^doc ([a-z]{4}) belongs to list "([^\"]*)" with (.*) "([^\"]*)"$/ do |docid, list_name, field, value|
  doc = Doc.find(docid)
  list = List.find_by_name(list_name)
  doc_in_list = ListedDoc.new(:doc => doc, :list => list)
  doc_in_list.send "#{field}=".to_sym, value
  doc_in_list.save!
end

Given /^I am not logged in$/ do
end

Given /^doc ([a-z]{4}) belongs to search "([^\"]*)" through a docid search$/ do |docid, search_name|
  doc = Doc.find(docid)
  search = Search.find_by_name(search_name)
  search.docids << doc
  search.save!
end

Given /^doc ([a-z]{4}) has author (\w+)$/ do |docid, author_name|
  doc = Doc.find(docid)
  author = Kbuser.find_by_username(author_name)
  doc.author = author
  doc.save!
end

Given /^search "([^\"]*)" has author (\w+)$/ do |search_name, author_name|
  search = Search.find_by_name(search_name)
  author = Kbuser.find_by_username(author_name)
  search.author = author
end

Given /^a boiler named "([^\"]*)"$/ do |name|
  Factory.create(:boiler, :name => name)
end

Given /^list "([^\"]*)" is a clone of (\d+)$/ do |name, wl1_id|
  list = List.find_by_name(name)
  list.wl1_clone = wl1_id
  list.save!
end

When /^I view the doc ([a-z]{4})$/ do |docid|
  visit formatted_doc_path(docid, 'html')
end

When /^I view the search "([^\"]*)"$/ do |search_name|
  visit root_path
  click_link "Searches"
  click_link search_name
end

When /^I view the boiler "([^\"]*)"$/ do |boiler_name|
  visit "/boilers/#{boiler_name}"
end

When /^I remove the search assigned to list "([^\"]*)"$/ do |name|
  list = List.find_by_name(name)
  list.search = nil
  list.save!
end

When /^I edit the list "([^\"]*)"$/ do |list_name|
  visit edit_list_path(List.find_by_name(list_name))
end

When /^I view the list "([^\"]*)"$/ do |list_name|
  visit list_path(List.find_by_name(list_name))
end

When /^I view doc ([a-z]{4}) as xml$/ do |docid|
  visit formatted_doc_path(docid, 'xml')
end

When /^I press the delete button$/ do
  # hack around confirmation dialog, from http://stackoverflow.com/questions/2458632/how-to-test-a-confirm-dialog-with-cucumber
  page.evaluate_script('window.confirm = function() { return true; }')
  page.click('X')
end

Then /^I should see <text> in "([^\"]*)" in the following order, starting with (\d+):$/ do |sibling, offset, table|
  table.hashes.each_with_index do |hash, i|
    steps %Q{Then I should see "#{hash['text']}" within "#{sibling}:nth-child(#{i + offset.to_i})"}
  end
end

Then /^I should see <text> in "([^\"]*)" in the following order:$/ do |sibling, table|
  previous_row = {}
  table.hashes.each_with_index do |row, i|
    if i ==0
      previous_row = row
      next
    end
    page.should have_xpath
    steps %Q{Then I should see /#{previous_row['text']}.*#{row['text']}/}
    previous_row = row
  end
end

Then /^I should see element "([^\"]*)"$/ do |element|
  page.should have_css element
end

Then /^I should not see element "([^\"]*)"$/ do |element|
  page.should_not have_css element
end

Then /^I should not see the word "([^\"]*)" within "([^\"]*)"$/ do |word, context|
  regexp = Regexp.new("\b"+word+"\b")
  within(context) do
    page.should_not have_xpath('//*', :text => regexp)
  end
end

Then /^I should see the following options checked:$/ do |table|
  table.hashes.each do |hash|
    page.should have_css("input#list_show_#{hash['option']}[checked]")
  end
end

Then /^I should see the following options unchecked:$/ do |table|
  table.hashes.each do |hash|
    page.should have_css("input#list_show_#{hash['option']}:not([checked])")
  end
end

Then /^I should see the following headings:$/ do |table|
  table.hashes.each do |hash|
    page.should have_css("th.#{hash[:heading]}-heading")
  end
  @total_headings = table.hashes.size
end

Then /^I should not see any other headings$/ do
  page.should_not have_css("th:nth-child(#{@total_headings+1})")
end

When /^I check the following boxes:$/ do |table|
  table.hashes.each do |hash|
    check "list_show_#{hash['checkbox']}"
  end
end

Then /^I should see "([^\"]*)" in the "([^\"]*)" cell of doc "([^\"]*)"$/ do |string, cell_class, docid|
  # select the <td> element in the same <tr> as a span with the docid in it. Ugly xpath.
  within("//tr//span[.='#{docid}']/../../td[@class='#{cell_class}']") do |cell|
    cell.should contain string
  end
end

Given /^the following docs exist:$/ do |table|
  table.hashes.each do |hash|
    doc = Doc.new
    doc.id = hash['docid']
    doc.modifieddate = hash['modifieddate']
    doc.save!
  end
end

Then /^I should see "([^\"]*)" above "([^\"]*)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end
