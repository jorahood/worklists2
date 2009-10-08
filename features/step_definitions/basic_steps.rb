Given /^I am viewing search (\d+)$/ do |id|
  visit search_path(id)
end

Given /^a list named "([^\"]*)"$/ do |name|
  List.create!(:name => name, :owner => User.find_by_name('user_a'))
end

Given /^a search named "([^\"]*)"$/ do |name|
  Search.create!(:name => name)
end

When /^I edit the worklist "([^\"]*)"$/ do |list_name|
  visit edit_list_path(List.find_by_name(list_name))
end

Then /^I should see \/(.*)\/ spanning multiple lines$/ do |regexp|
  regexp = Regexp.new(regexp, Regexp::MULTILINE)
  response.should contain(regexp)
end
