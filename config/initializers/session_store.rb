# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hoochies_session',
  :secret      => '8789228e9a2359ae22a4d09882a0954ac2614110da1770454a8d917a9da69ac00b534fb7734d5a33f022932c263edacd2472bf97f1a1ceb882f3091b0b6bf8b1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
