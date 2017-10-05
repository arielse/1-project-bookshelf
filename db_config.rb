require "active_record"

options = {
  adapter: 'postgresql',
  database: 'bookshelf'
}

# this is how to activate, must be at the bottom of the page.
ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
