Then /^I should first have to log into CAS$/ do
  response.should redirect_to("https://cas.iu.edu/cas/login?cassvc=ANY&casurl=http://www.example.com/")
end

When /^I am Paprika$/ do
  header('REMOTE_ADDR', '129.79.213.151')
end

Then /^I should not have to log into CAS first$/ do
  response.should_not be_redirect
end

Given /^Worklists2 is in a production environment$/ do
  ENV['RAILS_ENV'] = 'production'
end
