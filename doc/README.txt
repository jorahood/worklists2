Worklists2

*To update the development database from production, run rake mysql:refresh_from_production
* because of a change in deprec (http://github.com/mbailey/deprec/commit/effc3a833d1527a330ad9443e6a373d436d176f0#L3L294) in order for the deprec::push_database_yml
recipe to find database.yml on a multistaging environment you need to have it in config/#{stage}/database.yml. So config/staging/database.yml and config/prod/database.yml
Development notes:

  * list/show.dryml#<form>: removing owner="listed_doc" allows hobo to set the owner association for the note
to the current user when the form is here in the cell of a table-plus of listed_docs for a certain list, just like when editing a note from a listed_doc show page
  FIXME: What use is the owner attr for forms? I thought I had to set it to the model that the note belonged to, but Hobo figures it out ok without it -->
  * The server environment is set up using deprec and the application deployment is handled by capistrano, using the multistaging extensions in
    capistrano-ext. All of my custom deprec recipes for installing necesary libraries for talking to oracle are in config/deploy.rb

Deployment with Capistrano & deprec2:

Server setup:
  1. install Ubuntu 8.04 w/ OpenSSH server
  2. cap deprec:ssh:setup_keys will set up the pub key for bell for step 12 (looks for public key named wl2_rsa.pub in ~/.ssh dir on dev machine that matches the private key on bell)
  3. cap deprec:ssh:config_gen
  4. cap deprec:ssh:config
  5. cap deprec:rails:install_stack (my install_oci8 task is chained onto the end of this)
  6. cap deprec:db:install

Application deployment:
  7. cap deploy:setup (Note: when it asks, at this point the mysql 'root' db password will still be '')
  8. cap deploy
  9. cap db:bootstrap - builds database from RAILS_ENV_structure.sql (make sure db/RAILS_ENV_structure.sql is up to date! [now mysql 'root' password is set to the one in database.yml])
  10. cap deprec:postfix:install
  11. In crontab file, set MAILTO=worklist@indiana.edu (automate how?)
  12. set up ssh tunnel script on bell side: install script/autotunnel.sh on bell and run it detached with &

  13. cap craken:install to install crontab
update deploy recipe:

  1 commit all changes to git
  2 send your updates from git to the svn repository: git svn dcommit. This is important because the deploy scripts pull from the svn repository.
  3 cap deploy
  4 cap deploy:migrate (if necessary)

  database.yml: deprec assumes that if you are doing multistage deployment that it
  will be able to find a database.yml file in a subdir of config with the same name as the
   stage. I have symlinked database.yml from staging and prod subdirs to conform to this. 

Collations
   When I run a custom rake task that downloads the production data called mysql:refresh_from_production, all the tables that download have collation
utf8_general_ci, but tables that I have created on the development machine using migrations have collation utf8_unicode_ci. Once I run the migration
creating the new table on the production server and rerun mysql_refresh_from_production, the new table gets the utf8_general_ci collation.
Either the refresh task is setting the collation wrong, or Rails has changed its default collation from the time when I first installed the production servers.
FIXME: If the problem is due to Rails having changed default collations, I should run rake db:schema:load on the production machines to get them using
the utf8_unicode_ci collation to match the development db. Tried that and now my db has collation of latin1_swedish. I think it's best to not
pull data from production with the mysql:refresh task.