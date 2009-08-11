require 'deprec'
# http://github.com/mocoso/mysql_tasks/tree/master
load 'vendor/plugins/mysql_tasks/lib/mysql_deploy'

set :database_yml_in_scm, false
set :domain, "test-kmtools.uits.iu.edu"
set :application, "worklists2"
set :repository, 'svn+ssh://poblano.uits.indiana.edu/srv/svn/kb-support/trunk/worklists2'

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
#set :scm, :git
   
set :ruby_vm_type,      :ree        # :ree, :mri
set :web_server_type,   :apache     # :apache, :nginx
set :app_server_type,   :passenger  # :passenger, :mongrel
set :db_server_type,    :mysql      # :mysql, :postgresql, :sqlite

# set :packages_for_project, %w(libmagick9-dev imagemagick libfreeimage3) # list of packages to be installed
# set :gems_for_project, %w(rmagick mini_magick image_science) # list of gems to be installed

# Update these if you're not running everything on one host.
role :app, domain
role :web, domain
role :db,  domain, :primary => true
role :cron, domain # for craken: http://github.com/latimes/craken/tree/master

# If you aren't deploying to /opt/apps/#{application} on the target
# servers (which is the deprec default), you can specify the actual location
# via the :deploy_to variable:
#set :deploy_to, "/opt/apps/#{application}"

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    top.deprec.app.restart
  end
end

desc "Install InstantClient libraries"
task :install_instantclient, :roles => :db do
  run "svn export --force svn+ssh://poblano.uits.indiana.edu/srv/svn/kb-support/trunk/instantclient_10_1 /tmp/instantclient"
  run "#{sudo} mkdir /opt/oracle"
  run "#{sudo} mv /tmp/instantclient /opt/oracle/"
  # add the /opt/oracle/instantclient directory to the ld.so.conf path rather than using the LD_LIBRARY_PATH env variable,
  # which is a bitch to set in my bell:load rake task when installing it in cron with craken
  run "echo '/opt/oracle/instantclient' | #{sudo} tee /etc/ld.so.conf.d/instantclient.conf"
  # reload the dynamic loader cache so it finds instantclient.conf
  run "#{sudo} ldconfig"
end

desc "Install ruby-oci8 gem version 1.0.6"
task :install_oci8, :roles => :db do
	install_instantclient
    gem2.install 'ruby-oci8', '1.0.6'
end

desc "Bootstrap a new database install from {RAILS_ENV}_structure.sql instead of trying to run all migrations"
task :bootstrap_db, :roles => :db do
  run "mysql -u root -p#{Capistrano::CLI.password_prompt("Enter MySQL database password: ")} -f #{application}_#{rails_env} < #{deploy_to}/current/db/#{rails_env}_structure.sql"
end

after 'deprec:rails:install_stack', :install_oci8
