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

enable :sessions # Sinatra allows sessions

# helpers is from Sinatra, it allows you to use methods across the whole site.
helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end
  def logged_in?
    if current_user
      true
    else
      false
    end
  end
end

get '/' do

  erb :index
end

get '/login' do
  @message = ''
  erb :login
end

# start session after login
post '/session' do
  # find user
  user = User.find_by(email: params[:email])
  # if found user
  if user && user.authenticate(params[:password])
    # successful create session then redirect1
    session[:user_id] = user.id
    redirect '/'
  else
    @message = 'incorrect email or password'
    erb :login
  end
end

delete '/session' do
  # deletes the session id, which logs the person out
  session[:user_id] = nil
  redirect '/login'
end
