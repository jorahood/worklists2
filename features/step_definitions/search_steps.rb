Given /^I am editing a new unsaved search$/ do
  visit searches_path
end

When /^it has no name$/ do
  pending
end

Then /^saving it should give me a validation error that says "([^\"]*)"$/ do |arg1|
  pending
end
