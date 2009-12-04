Given /^I am viewing search (\d+)$/ do |id|
  visit search_path(id)
end

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

Given /^doc ([a-z]{4}) has note (\d+) in list "([^\"]*)"$/ do |docid, note_id, list_name|
  doc = Doc.find(docid)
  note = Note.find(note_id)
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

When /^I view the search "([^\"]*)"$/ do |search_name|
  visit search_path(Search.find_by_name(search_name))
end

When /^I remove the search assigned to list "([^\"]*)"$/ do |list_name|
  list = List.find_by_name(list_name)
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

When /^I select "([^\"]*)"$/ do |value|
  select value
end

Then /^I should see "([^\"]*)" in the body$/ do |stuff|
  steps %Q{Then I should see "#{stuff}" within "div.content-body"}
end

Then /^I should not see "([^\"]*)" in the body$/ do |stuff|
  steps %Q{Then I should not see "#{stuff}" within "div.content-body"}
end

Then /^I should see element "([^\"]*)" within "([^\"]*)"$/ do |element, context|
  within(context) do |content|
    content.should match_selector(element)
  end
end

Then /^I should not see element "([^\"]*)" within "([^\"]*)"$/ do |element, context|
  within(context) do |content|
    content.should_not match_selector(element)
  end
end

Then /^I should not see the word "([^\"]*)" within "([^\"]*)"$/ do |word, context|
  regexp = Regexp.new("\b"+word+"\b")
  within(context) do |content|
    content.should_not contain(regexp)
  end
end

Then /^I should see the following options checked:$/ do |table|
  table.hashes.each do |hash|
    within("form.new") do |content|
      response.should match_selector("input#list_show_#{hash['option']}[checked]")
    end
  end
end

Then /^I should see the following options unchecked:$/ do |table|
  table.hashes.each do |hash|
    within("form.new") do |content|
      content.should match_selector("input#list_show_#{hash['option']}:not([checked])")
    end
  end
end

Then /^I should see the following headings:$/ do |table|
  table.hashes.each do |hash|
    within("tr.field-heading-row") do |content|
      content.should match_selector("th.#{hash[:heading]}-heading")
    end
  end
  @total_headings = table.hashes.size
end

When /^I check the following boxes:$/ do |table|
  table.hashes.each do |hash|
    check "list_show_#{hash['checkbox']}"
  end
end

And /^I should not see any other headings$/ do
  within("tr.field-heading-row") do |content|
    content.should_not match_selector("th:nth-child(#{@total_headings+1})")
  end
end

Then /^I should see "([^\"]*)" in the "([^\"]*)" cell of doc "([^\"]*)"$/ do |string, cell, docid|
  # select the <td> element in the same <tr> as a span with the docid in it. Ugly xpath.
  within("//tr//span[.='#{docid}']/../../td[@class='#{cell}']") do |cell|
    cell.should contain string
  end

end
