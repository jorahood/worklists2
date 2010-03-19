Given /^I am logged in as (\w+)$/ do |username|
  Given "a kbuser named #{username}"
  And "I am logged into CAS as #{username}"
end

Given /^I am logged into CAS as (\w+)$/ do |username|
  visit '/?backdoor_login=' + username
end

Then /^I should first have to log into CAS$/ do
  response.should redirect_to("https://cas.iu.edu/cas/login?cassvc=ANY&casurl=http://www.example.com/")
end

When /^I am Dolga$/ do
  header('REMOTE_ADDR', '10.79.213.197')
end

Then /^I should not have to log into CAS first$/ do
  response.should_not be_redirect
end

Given /^Worklists2 is in a production environment$/ do
  ENV['RAILS_ENV'] = 'production'
end
