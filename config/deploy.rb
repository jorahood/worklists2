set :application, "worklists2"
set :domain, "156.56.19.9"
set :deploy_to, "/var/rails/#{application}"
set :repository, 'svn+ssh://poblano.uits.indiana.edu/srv/svn/kb-support/branches/worklists2-r0.2-boilerlist.cgi'
set :ssh_flags, '-A'
