# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sapling_session',
  :secret      => 'e179b97f0a99b73ed5e42738181b096fee762b6da7b48f49af2503763bcf0e268a2c200882010b566011335e74a08fde461889d51dd139668e05a2a3fbd3ccae'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
