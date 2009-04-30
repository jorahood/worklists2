# rake tasks to import the tables from the kb3 Oracle db on bell. The task names
# are generated from the model names listed in config/bell_tables.yml and then
# an "all" task is generated to run all of the imports in the order they appear
# in bell_tables.yml

namespace :bell do

  bell_tables = YAML.load_file("#{RAILS_ROOT}/config/bell_tables.yml")

  bell_tables.each do |wl2_table_name, bell_source_config|

    #http://api.rubyonrails.org/classes/ActiveSupport/CoreExtensions/String/Inflections.html#M001338
    desc "Reload '#{wl2_table_name}' from kbadm.#{bell_source_config[:table_name]}"
    task wl2_table_name => :environment do
      # ar-extensions allows us to do mass loading of data into tables,
      # bypassing validations to speed things up by orders of magnitude
      # see http://www.jobwd.com/article/show/31
      require 'ar-extensions'
      require 'ar-extensions/adapters/mysql'
      require 'ar-extensions/import/mysql'
      wl2_model_name = wl2_table_name.classify.constantize
      class OracleOnBell < ActiveRecord::Base
      end
      # FIXME: need a check here to make sure the ssh tunnel is available
      OracleOnBell.establish_connection :oracle_on_bell

      # all_records is an array of hashes of column => value pairs, returned by
      # #select_all. Getting the data this way rather than as an array of arrays
      # of values as #select_values returns it obviates the need to know the exact
      # order that #select_values returns the data in, which has no relation to
      # the order the columns are returned by #columns
      puts "\n   ** #{wl2_model_name} **"
      all_records = OracleOnBell.connection.select_all("SELECT * FROM kbadm.#{bell_source_config[:table_name]}")
      columns = all_records[0].keys
      puts "1. Read #{all_records.length} records from bell:kbadm.#{bell_source_config[:table_name]}:\n\t#{columns.to_sentence}"
      if  bell_source_config[:rename_columns]
        columns = columns.map {|bell_column| bell_source_config[:rename_columns][bell_column] || bell_column}
      end
      values = all_records.map { |record| record.values }
      #FIXME: check that the values we got from Oracle are good before truncating and reloading the wl2 table
      #FIXME: check that wl2_table_name exists and is one of the imported tables, not a wl2 list table before truncating
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{wl2_table_name}")
      puts "2. Truncated worklists2_#{RAILS_ENV}.#{wl2_table_name} table"
      wl2_model_name.import columns, values, :on_duplicate_key_update => columns, :validate => false
      puts "3. Imported #{all_records.length} #{wl2_table_name}:\n\t#{columns.to_sentence}"
    end
  end

  desc "Reload #{bell_tables.length} tables from bell: \n\t#{bell_tables.keys.to_sentence}"
  task :all => bell_tables.keys #pass the array of all our autogenerated tasks as dependencies to the bell:all task
end
