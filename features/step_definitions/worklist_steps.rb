Given /^a search$/ do
  @search = Search.create!(:name => 'booger')
end

When /^I save the search as a list$/ do
  @list = @search.save_as_list
end

Then /^a new list should be created$/ do
  @list.should be_an_instance_of(List)
end

Then /^the new list should belong to the search$/ do
pending
  #  @search.lists.should include(@list)
end

