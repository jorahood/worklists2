class ApplicationController
  # faking #get_cas_username because I can't figure out how to get at the
  # session[:cas_user] value before #set_current_user_from_cas_username runs as a
  # before_filter.
  def get_cas_username
    params[:username]
  end


end

Given /^I am logged in as "([^\"]*)"$/ do |username|
  Given "a kbuser named \"#{username}\""
  get '/', :username => username
end

When /^I am logged into CAS as "([^\"]*)" and go to the homepage$/ do |username|
  get '/', :username => username
end

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