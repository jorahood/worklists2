Given /^I am logged in as (\w+)$/ do |username|
  Given "a kbuser named #{username}"
  And "I am logged into CAS as #{username}"
end

Given /^I am logged into CAS as (\w+)$/ do |username|
  visit '/?backdoor_login=' + username
end

Then /^I should first have to log into CAS$/ do
  page.current_url.should match Regexp.new("cas.iu.edu")
end

Then /^I should not have to log into CAS first$/ do
  page.current_url.should_not match Regexp.new("cas.iu.edu")
end

Given /^Worklists2 is in a production environment$/ do
  ENV['RAILS_ENV'] = 'production'
end
