# rake task to import the tables from the kb3 Oracle db on bell. The task
# takes as an argument either a model name or 'all' to load all models with
# import_from_bell == true

namespace :bell do
  desc "Reload a model (e.g. 'docs', default='all') from bell"
  # rake tasks with arguments: http://rake.rubyforge.org/files/doc/release_notes/rake-0_8_3_rdoc.html
  task :load, :model, :needs => :environment do |t, args|
    # args.with_defaults: http://dev.nuclearrooster.com/2009/01/05/rake-task-with-arguments/
    args.with_defaults(:model => 'all')
    models_from_bell = (args.model == 'all') ?
      Hobo::Model.all_models.select {|m| m.import_from_bell} :
      [args.model.classify.constantize]
    models_from_bell.each do |model|
      table = model.table_name
      bell_table = "kbadm.#{table}"
      # ar-extensions allows us to do mass loading of data into tables,
      # bypassing validations to speed things up by orders of magnitude
      # see http://www.jobwd.com/article/show/31
      require 'ar-extensions'
      require 'ar-extensions/adapters/mysql'
      require 'ar-extensions/import/mysql'

      puts "\n   ** #{model} **"
      OracleOnBell.establish_connection :oracle_on_bell
      all_records = OracleOnBell.connection.select_all("SELECT * FROM #{bell_table}")
      # all_records is an array of hashes of column => value pairs, returned by
      # #select_all. Getting the data this way rather than as an array of arrays
      # of values as #select_values returns it obviates the need to know the exact
      # order that #select_values returns the data in, which has no relation to
      # the order the columns are returned by #columns, since we can look at the
      # data itself to get the column order. E.g., bell_columns
      bell_columns = all_records[0].keys
      bell_values = all_records.map { |record| record.values }

      puts "1. Read #{all_records.length} records from 'bell:#{bell_table}'.
     Columns: #{bell_columns.to_sentence}"
      #FIXME: check that the values we got from Oracle are good before truncating and reloading the wl2 table
      ActiveRecord::Base.establish_connection
      # wrap the truncation and importing in a transaction so no client sees empty tables
      ActiveRecord::Base.transaction do
        ActiveRecord::Base.connection.execute("DELETE FROM #{ActiveRecord::Base.connection.quote_table_name(table)}")
        puts "2. Deleted all records from 'worklists2_#{RAILS_ENV}.#{table}'."
        model.import bell_columns, bell_values, :validate => false
        puts "3. Imported #{all_records.length} instances of #{model}."
      end
    end
    puts "\nImported #{models_from_bell.length} ActiveRecord model classes from bell." if models_from_bell.length > 1
  end
end
