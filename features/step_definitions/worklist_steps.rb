Given /^a search$/ do
  @search = Search.create!
end

When /^I save the search as a list$/ do
  @search.save_as_list
end

Then /^a new list should be created$/ do
  @search.list.should be_an_instance_of(List)
end

Then /^the new list should belong to the search$/ do
  pending
end

