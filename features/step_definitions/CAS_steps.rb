Then /^I should be redirected to "([^\"]*)"$/ do |url|
  response.should redirect_to(url)
end

When /^Paprika goes to the homepage$/ do
  header('REMOTE_ADDR', '129.79.213.151')
  visit '/'
end

Then /^I should not be redirected$/ do
  response.should_not be_redirect
end

Given /^I am not logged into CAS$/ do

end

Given /^I am testing the application$/ do
  
end
