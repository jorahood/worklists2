namespace :andy do
  namespace :mysql do
    desc "back up any tables that are not copies of bell tables. Requires the mysql_tasks plugin"
    task :dump_nonbell => :environment do
      file_path = File.join('/tmp', git_module, "#{RAILS_ENV}_data.sql")
      models_not_from_bell = Hobo::Model.all_models.reject {|m| m.import_from_bell || m.superclass == Worklists1}
      tables = models_not_from_bell.collect{|m| m.table_name}
      tables_string = tables.join(' ')
      # for defs of #sh_mysqldump and #database_config, see vendor/plugins/mysql_tasks/tasks/mysql_tasks.rake
      `#{sh_mysqldump(database_config)} #{tables_string} > #{file_path}`
    end

    task :commit_dump => :dump_nonbell do

    end

    task :push_dump => :commit_dump do

    end

    task :back_up_to_github => :push_dump

    def git_module
      "worklists2_backup"
    end

  end
end

