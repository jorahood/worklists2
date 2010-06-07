# rake task to import the tables from the kb3 Oracle db on bell. The task
# takes as an argument either a model name or 'all' to load all models with
# import_from_bell == true

namespace :bell do
  desc "Reload a model (e.g. 'docs', default='all') from bell"
  # rake tasks with arguments: http://rake.rubyforge.org/files/doc/release_notes/rake-0_8_3_rdoc.html
  task :load, :model, :needs => :environment do |t, args|
    # ar-extensions allows us to do mass loading of data into tables,
    # bypassing validations to speed things up by orders of magnitude
    # see http://www.jobwd.com/article/show/31
    require 'ar-extensions'
    require 'ar-extensions/adapters/mysql'
    require 'ar-extensions/import/mysql'
    # args.with_defaults: http://dev.nuclearrooster.com/2009/01/05/rake-task-with-arguments/
    args.with_defaults(:model => 'all')
    models_from_bell = (args.model == 'all') ?
      Hobo::Model.all_models.select {|m| m.import_from_bell} :
      [args.model.classify.constantize]
    models_from_bell.each do |model|
      table = model.table_name
      bell_table = "kbadm.#{table}"

      puts "\n   ** #{model} **"
      OracleOnBell.establish_connection :oracle_on_bell
      hash = OracleOnBell.connection.select_all("SELECT * FROM #{bell_table} WHERE ROWNUM < 2")
      # the docs for Activerecord claim that #select_rows is supposed to return an array of values with the column order
      # the same as that returned by #columns
      # (http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/DatabaseStatements.html#M001422) but this
      # isn't the case for the oracle adapter. So since I can't get the column order via #columns I'm using #select_all
      # and limiting the result to one return with ROWNUM < 2 then taking the column names from the keys of that hash
      # which do happen to be in the same order as the values returned by #select_rows .
      bell_columns = hash[0].keys
      bell_values = OracleOnBell.connection.select_rows("SELECT * FROM #{bell_table}")
      total = bell_values.length
      puts "1. Read #{total} records from 'bell:#{bell_table}'.
     Columns: #{bell_columns.to_sentence}"
      # #FIXME: check that the values we got from Oracle are good before deleting and reloading the wl2 table
      # ar_extensions' #create_temporary_table will not work because you cannot do RENAME TABLE on a temporary table in
      # mysql and I need to use RENAME for atomicity so concurrent sessions don't see empty or nonexistent
      # tables. So instead create a temporary model myself and derive its table name from the given model
      class TempModel < model
        set_table_name "temp_#{superclass.table_name}"
      end
      # mysql is picky about table names so I'm using ActiveRecord::Base#quote_table_name to sanitize them for use in SQL
      # strings:
      q_table = ActiveRecord::Base.connection.quote_table_name(table)
      q_temp_table = ActiveRecord::Base.connection.quote_table_name(TempModel.table_name)
      # use a unique(ish) name for the old table in order to avoid table name collisions with other
      # instances of this task running at the same time on the same db
      q_old_table = ActiveRecord::Base.connection.quote_table_name(table+"_old")
      # clone the structure of the model's existing table for the temporary table
      ActiveRecord::Base.connection.execute("CREATE TABLE #{q_temp_table} LIKE #{q_table}")
      puts "2. Created temporary table #{q_temp_table}."
      # import the data into the temporary table in slices, since with datasets over 800000, #import dies with a "stack
      # level too deep", and over 1000000, mysql seg faults
      bell_values.each_slice(500000) do |bell_values_slice|
        TempModel.import bell_columns, bell_values_slice, :validate => false
      end
      puts "3. Imported #{total} #{model.to_s.pluralize}."
      # rename is an atomic operation so all other connections will only see q_table after both renames
      ActiveRecord::Base.connection.execute("RENAME TABLE #{q_table} TO #{q_old_table},
                                                                                      #{q_temp_table} TO #{q_table}")
      puts "4. Renamed tables #{q_table} to #{q_old_table}, #{q_temp_table} to #{q_table}."
      ActiveRecord::Base.connection.execute("DROP TABLE #{q_old_table}")
      puts "5. Dropped table #{q_old_table}."
    end
    puts "\nImported #{models_from_bell.length} ActiveRecord model classes from bell." if models_from_bell.length > 1
  end
end
