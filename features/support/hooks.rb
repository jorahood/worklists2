# ensure the RAILS_ENV gets reset correctly after scenarios that set RAILS_ENV
# to 'production', e.g., the CAS scenarios
After("@production_rails_env") do
  ENV['RAILS_ENV'] = 'cucumber'
end