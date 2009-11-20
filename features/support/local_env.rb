#set up fixtures
require 'cucumber/rails/rspec'
Fixtures.reset_cache
fixtures_folder = File.join(RAILS_ROOT, 'spec', 'fixtures')
fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
table_names = fixtures.map{|fixture|fixture.classify.constantize.table_name}
Fixtures.create_fixtures(fixtures_folder, table_names)

# support stubs:
require "spec/mocks"

# pretty formatting
require File.expand_path(File.dirname(__FILE__) + '/textmate_formatter')