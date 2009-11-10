Given /^I am logged in as "([^\"]*)"$/ do |name|
  @me = User.create!(:name => name,
    :email_address => "#{name}@example.com",
    :password => 'valid_password')
  visit "/login"
  fill_in :login, :with => @me.email_address
  fill_in :password, :with => @me.password
  click_button "Log in"
end

Given /^I am viewing search (\d+)$/ do |id|
  visit search_path(id)
end

Given /^a user named "([^\"]*)"$/ do |name|
  User.create!(:name => name, :email_address => name + '@example.com')
end

Given /^a list named "([^\"]*)" owned by "([^\"]*)"$/ do |list_name, user_name|
  List.create!(:name => list_name, :owner => User.find_by_name(user_name))
end

Given /^a search named "([^\"]*)"$/ do |name|
  Search.create!(:name => name)
end

Given /^a doc with id "([^\"]*)"$/ do |docid|
  doc = Doc.new
  doc.id = docid
  doc.save!
end

Given /^search "([^\"]*)" returns doc "([^\"]*)"$/ do |search_name, docid|
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

Given /^doc "([^\"]*)" has note (\d+) in list "([^\"]*)"$/ do |docid, note_id, list_name|
  doc = Doc.find(docid)
  note = Note.find(note_id)
  list = List.find_by_name(list_name)
  doc_in_list = ListedDoc.new(:doc => doc, :list => list)
  doc_in_list.notes << note
  doc_in_list.save!
end

Given /^doc "([^\"]*)" belongs to list "([^\"]*)"$/ do |docid, list_name|
  doc = Doc.find(docid)
  list = List.find_by_name(list_name)
  list.docs << doc
  list.save!
end

Given /^I am not logged in$/ do
end

Given /^doc "([^\"]*)" belongs to search "([^\"]*)" through a docid search$/ do |docid, search_name|
  doc = Doc.find(docid)
  search = Search.find_by_name(search_name)
  search.docids << doc
  search.save!
end

Given /^a kbuser named "([^\"]*)"$/ do |name|
  kbuser = Kbuser.create!(:username => name)
end

Given /^doc "([^\"]*)" has author "([^\"]*)"$/ do |docid, author_name|
  doc = Doc.find(docid)
  author = Kbuser.find_by_username(author_name)
  doc.author = author
  doc.save!
end

Given /^search "([^\"]*)" has author "([^\"]*)"$/ do |search_name, author_name|
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

When /^I edit the worklist "([^\"]*)"$/ do |list_name|
  visit edit_list_path(List.find_by_name(list_name))
end

When /^I view the list "([^\"]*)"$/ do |list_name|
  visit list_path(List.find_by_name(list_name))
end

When /^I view doc "([^\"]*)" as xml$/ do |docid|
  visit formatted_doc_path(docid, 'xml')
end

When /^I select "([^\"]*)"$/ do |value|
  select value
end

Then /^I should see "([^\"]*)" in the body$/ do |stuff|
  Then "I should see \"#{stuff}\" within \"div.content-body\""
end

Then /^I should not see "([^\"]*)" in the body$/ do |stuff|
  Then "I should not see \"#{stuff}\" within \"div.content-body\""
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

Then /^I should see the following options within "([^\"]*)":$/ do |context, options_table|
  options_table.hashes.each do |hash|
    within(context) do |content|
      content.should contain("Show " + hash['option'])
    end
  end
end
