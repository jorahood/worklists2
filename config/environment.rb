# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
#RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  # You have to specify the :lib option for libraries, where the Gem name (sqlite3-ruby) differs from the file itself (sqlite3)
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  # ar-extensions 0.9.2.1 contains my changes to provide compatibiltity with models using composite_primary_key gem
  # http://github.com/jorahood/ar-extensions/commits/composite_compat
  config.gem 'ar-extensions',
    :version => '0.9.2.1'

  # :lib config value found at http://www.foliosus.com/blog/connecting-ruby-on-rails-to-oracle-on-an-intel-mac-in-leopard-take-2 : see comment 7
  config.gem 'activerecord-oracle-adapter',
    :version => '1.0.0.9250',
    :lib => 'active_record/connection_adapters/oracle_adapter',
    :source => 'http://gems.rubyonrails.org'
  config.gem 'composite_primary_keys',
    :version => '2.3.5.1'
  #rubycas-client 2.0.99.1 makes the rubycas client compatible with IU CAS. I will keep a rebased version available under the iu tag at 
  #http://github.com/jorahood/rubycas-client/
  config.gem 'rubycas-client',
    :version => '2.0.99.1'
  config.gem 'hobo',
    :version => '0.9.106'
  
  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Comment line to use default local time.
  config.time_zone = 'Eastern Time (US & Canada)'

  # The internationalization framework can be changed to have another default locale (standard is :en) or more load paths.
  # All files from config/locales/*.rb,yml are added automatically.
  # config.i18n.load_path << Dir[File.join(RAILS_ROOT, 'my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_wl2_session',
    :secret      => 'fbb5a6fe8851f899911efcad9ea2095f53954dde9c1bdb66a8cf055e6cbb8f4977f22b6e38479e5ce4f334406d1c3b88b726c6ce6194ae275eef73e64453efa2'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # Please note that observers generated using script/generate observer need to have an _observer suffix
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
end
