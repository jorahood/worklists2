Then /^I should be redirected to "([^\"]*)"$/ do |url|
  response.should redirect_to(url)
end

When /^I am Paprika$/ do
  header('REMOTE_ADDR', '129.79.213.151')
end

Then /^I should not be redirected$/ do
  response.should_not be_redirect
end

Given /^Worklists2 is in a production environment$/ do
  ENV['RAILS_ENV'] = 'production'
end

Then /^Worklists2 should be reset to a testing environment$/ do
  ENV['RAILS_ENV'] = 'cucumber'
end
