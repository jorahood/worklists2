# ensure the RAILS_ENV gets reset correctly after scenarios that set RAILS_ENV
# to 'production', e.g., the CAS scenarios
After("@production_rails_env") do
  ENV['RAILS_ENV'] = 'cucumber'
end

# running Selenium tests requires turning off transactional fixtures
# so we need to manually clear database tables on Scenarios that turn them off
After("@no-txn") do
  Hobo::Model.all_models.each do |model|
    table_name = ActiveRecord::Base.connection.quote_table_name(model.table_name)
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table_name}")
  end
end