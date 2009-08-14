require 'deprec'
# http://github.com/mocoso/mysql_tasks/tree/master
load 'vendor/plugins/mysql_tasks/lib/mysql_deploy'
# cap multistaging support
set :stages, %w(staging prod)
#set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :database_yml_in_scm, false
set :application, "worklists2"
set :repository, 'svn+ssh://poblano.uits.indiana.edu/srv/svn/kb-support/trunk/worklists2'

# ssh keys to be copied to server.
# id_dsa.pub is for connecting from my development machine,
# wl2_rsa.pub is for a connection initiated from my bell account
# (private key is stored at bell:.ssh/wl2_rsa) tunnelling for port 1521 from bell to the server
ssh_options[:keys] = %w(/Users/jorahood/.ssh/id_dsa /Users/jorahood/.ssh/wl2_rsa)

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
#set :scm, :git
   
set :ruby_vm_type,      :ree        # :ree, :mri
set :web_server_type,   :apache     # :apache, :nginx
set :app_server_type,   :passenger  # :passenger, :mongrel
set :db_server_type,    :mysql      # :mysql, :postgresql, :sqlite

# set :packages_for_project, %w(libmagick9-dev imagemagick libfreeimage3) # list of packages to be installed
# set :gems_for_project, %w(rmagick mini_magick image_science) # list of gems to be installed

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

desc "Upload the svn repo hostkey"
task :upload_poblano_hostkey, :roles => :app do
  put(File.read('/Users/jorahood/.ssh/poblano_hostkey'), '.ssh/known_hosts', :mode => 0600 )
end

namespace :db do
  namespace :prod do
    desc "Bootstrap a new database install from {RAILS_ENV}_structure.sql instead of trying to run all migrations"
    task :bootstrap, :roles => :db do
      run "mysql -u root -p#{Capistrano::CLI.password_prompt("Enter MySQL database password: ")} -f " +
        "#{application}_#{rails_env} < #{deploy_to}/#{current_dir}/db/#{rails_env}_structure.sql"
    end
  end
end

task :uname do
  run "uname -a"
end

# Patching deprec:ssh:setup_keys until my fix gets packaged in the official gem:
# http://github.com/mbailey/deprec/commit/965df1de43f9fa8c6ddb7acfe2f35ad99769bf9c
namespace :deprec do
  namespace :ssh do
    desc "Sets up authorized_keys file on remote server"
    task :setup_keys do

      default(:target_user) {
        Capistrano::CLI.ui.ask "Setup keys for which user?" do |q|
          q.default = user
        end
      }

      # If we have an authorized keys file for this user
      # then copy that out
      if File.exists?("config/ssh/authorized_keys/#{target_user}")
        deprec2.mkdir "/home/#{target_user}/.ssh", :mode => 0700, :owner => "#{target_user}.users", :via => :sudo
        std.su_put File.read("config/ssh/authorized_keys/#{target_user}"), "/home/#{target_user}/.ssh/authorized_keys", '/tmp/', :mode => 0600
        sudo "chown #{target_user}.users /home/#{target_user}/.ssh/authorized_keys"

      elsif target_user == user

        # If the user has specified a key Capistrano should use
        if ssh_options[:keys]
          deprec2.mkdir '.ssh', :mode => 0700
          put(ssh_options[:keys].collect{|key| File.read(key+'.pub')}.join("\n"), '.ssh/authorized_keys', :mode => 0600 )

          # Try to find the current users public key
        elsif keys = %w[id_rsa id_dsa identity].collect { |f| "#{ENV['HOME']}/.ssh/#{f}.pub" if File.exists?("#{ENV['HOME']}/.ssh/#{f}.pub") }.compact
          deprec2.mkdir '.ssh', :mode => 0700
          put(keys.collect{|key| File.read(key)}.join("\n"), '.ssh/authorized_keys', :mode => 0600 )

        else
          puts <<-ERROR

            You need to define the name of your SSH key(s)
            e.g. ssh_options[:keys] = %w(/Users/your_username/.ssh/id_rsa)

            You can put this in your .caprc file in your home directory.

          ERROR
          exit
        end
      else
        puts <<-ERROR

          Could not find ssh public key(s) for user #{user}

          Please create file containing ssh public keys in:

            config/ssh/authorized_keys/#{target_user}

        ERROR
      end

    end

  end
end

after 'deprec:rails:install_stack', :install_oci8
after 'deprec:ssh:setup_keys', :upload_poblano_hostkey