Given /^I am editing search (\d+)$/ do |id|
  visit edit_search_path(id)
end
