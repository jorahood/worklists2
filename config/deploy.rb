require 'deprec'

set :database_yml_in_scm, false
set :domain, "156.56.19.9"
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
end

desc "Install ruby-oci8 gem"
task :install_oci8, :roles => :db do
    run "#{sudo} LD_LIBRARY_PATH=/opt/oracle/instantclient gem install --no-rdoc --no-ri ruby-oci8"
end
