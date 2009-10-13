Given /^I am logged in$/ do
  @me = User.create!(:name => 'dummy',
    :email_address => 'dummy@example.com',
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

Given /^a list named "([^\"]*)" owned by "([^\"]*)"$/ do |list, user|
  List.create!(:name => list, :owner => User.find_by_name(user))
end

Given /^a search named "([^\"]*)"$/ do |name|
  Search.create!(:name => name)
end

Given /^a doc with id "([^\"]*)"$/ do |docid|
  doc = Doc.new
  doc.id = docid
  doc.save!
end

Given /^search "([^\"]*)" includes doc "([^\"]*)"$/ do |search_name, docid|
  search = Search.find_by_name(search_name)
  search.stub!(:perform).and_return([Doc.find(docid)])
end

When /^I edit the worklist "([^\"]*)"$/ do |list_name|
  visit edit_list_path(List.find_by_name(list_name))
end

Then /^I should see \/(.*)\/ spanning multiple lines$/ do |regexp|
  regexp = Regexp.new(regexp, Regexp::MULTILINE)
  response.should contain(regexp)
end
