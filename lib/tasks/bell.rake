#http://blog.internautdesign.com/2008/6/14/array-of-all-activerecord-models-in-a-rails-app
#all_models = Dir.glob( File.join( RAILS_ROOT, 'app', 'models', '*.rb') ).map{|path| path[/.+\/(.+).rb/,1] }
#AR_models = all_models.select{|m| m.classify.constantize < ActiveRecord::Base}
#Dir.glob(RAILS_ROOT + '/app/models/*.rb').each { |file| require file }

# rake tasks to import the tables from the kb3 Oracle db on bell. The task names
# are generated from the model names themselves and then
# an "all" task is generated to run all of the imports 

namespace :bell do
  desc "Reload data for model_name (default 'all') from bell"
  # rake tasks with arguments: http://rake.rubyforge.org/files/doc/release_notes/rake-0_8_3_rdoc.html
  task :load, :model_name, :needs => :environment do |t, args|
    # args.with_defaults: http://dev.nuclearrooster.com/2009/01/05/rake-task-with-arguments/
    args.with_defaults(:model_name => Status)
    model = args.model_name.constantize
    #    models_from_bell = Hobo::Model.all_models.select &:import_from_bell
    column_sql = model.column_names.join(', ')
    #    models_from_bell.each do |model|
    table = model.table_name
    # ar-extensions allows us to do mass loading of data into tables,
    # bypassing validations to speed things up by orders of magnitude
    # see http://www.jobwd.com/article/show/31
    require 'ar-extensions'
    require 'ar-extensions/adapters/mysql'
    require 'ar-extensions/import/mysql'

    # all_records is an array of hashes of column => value pairs, returned by
    # #select_all. Getting the data this way rather than as an array of arrays
    # of values as #select_values returns it obviates the need to know the exact
    # order that #select_values returns the data in, which has no relation to
    # the order the columns are returned by #columns

    puts "\n   ** #{model} **"
    OracleOnBell.establish_connection :oracle_on_bell
    all_records = OracleOnBell.connection.select_all("SELECT * FROM kbadm.#{table}")
    bell_columns = all_records[0].keys
    bell_values = all_records.map { |record| record.values }

    puts "1. Read #{all_records.length} records from bell:kbadm.#{table}:
      #{bell_columns.to_sentence}"
    #FIXME: check that the values we got from Oracle are good before truncating and reloading the wl2 table
    ActiveRecord::Base.establish_connection
    # wrap the truncation and importing in a transaction so no client sees empty tables
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table}")
      puts "2. Truncated worklists2_#{RAILS_ENV}.#{table} table"
      model.import bell_columns, bell_values, :validate => false
      puts "3. Imported #{all_records.length} records into worklists2_#{RAILS_ENV}.#{table}"
    end
    #end
  end
end
