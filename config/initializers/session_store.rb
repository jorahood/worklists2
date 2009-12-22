# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_worklists2_session',
  :secret      => '898b0159671176d4be9439df17de42dc941dda86220d872575c1a0797c49051d0ae5de560a2053feb34c8c3c48c8eedba829d2505ae3de42414596fe2f0d7499'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
