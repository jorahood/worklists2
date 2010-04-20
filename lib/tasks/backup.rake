namespace :andy do
  namespace :mysql do

    task :dump_tables => :environment do
      file_path = File.join(base_dir, git_module, filename)
      # select models to dump that aren't copied from bell or worklists1
      models_to_dump = Hobo::Model.all_models.reject {|m| m.import_from_bell || m.superclass == Worklists1}
      tables = models_to_dump.collect{|m| m.table_name}
      # for defs of #sh_mysqldump and #database_config, see vendor/plugins/mysql_tasks/tasks/mysql_tasks.rake
      `#{sh_mysqldump(database_config)} #{tables.join(' ')} > #{file_path}`
    end

    task :add_dump do
      `cd #{File.join(base_dir, git_module)} && git add #{filename}`
    end

    task :commit_dump do
      `cd #{File.join(base_dir, git_module)} && git commit -m 'backup commit'`
    end

    task :push_dump do
      `cd #{File.join(base_dir, git_module)} && git push github`
    end

    task :back_up_to_github => [:dump_tables, :add_dump, :commit_dump, :push_dump]

    def base_dir
      '/tmp'
    end

    def git_module
      "worklists2_backup"
    end

    def filename
      "#{RAILS_ENV}_data.sql"
    end
  end
end

