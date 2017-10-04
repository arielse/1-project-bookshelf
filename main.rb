require "sinatra"
require "sinatra/reloader"
# PG is the library used to do commands in PostGreSQL like "conn" below
require "pg"
require "pry"
require_relative "db_config"
require_relative "models/user"
require_relative "models/review"
require_relative "models/book"
require_relative "models/shelf"

get '/' do

  erb :index
end

get '/login' do

  erb :login
end
