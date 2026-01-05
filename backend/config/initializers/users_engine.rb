# config/initializers/users_engine.rb

# Token expiration: 1 month
UsersEngine.access_token_expires_in = ->(_context) { 1.month }
