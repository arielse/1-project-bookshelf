require "sinatra"
# require "sinatra/reloader"
# PG is the library used to do commands in PostGreSQL like "conn" below
require "pg"
require "pry"
require "httparty"
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

# logout
delete '/session' do
  # deletes the session id, which logs the person out
  session[:user_id] = nil
  redirect '/'
end

get '/register' do
  erb :register
end

post '/register' do
  if User.find_by(email: params[:email])
    @message = 'email address already in use'
    erb :register
  else
    User.create(username: params[:username], email: params[:email], password: params[:password])
    redirect '/login'
  end
end

get '/userinfo' do
  @username = current_user.username
  @about_user = current_user.about_user
  erb :userinfo
end

get '/edit_userinfo' do
  @username = current_user.username
  @about_user = current_user.about_user
  erb :edit_userinfo
end

put '/edit_userinfo' do
  @user = current_user
  @user.about_user = params[:about_me]
  @user.save
  redirect '/userinfo'
end

get '/booksearch' do

  erb :booksearch
end

get '/booklist' do
  input_title = params[:book_title]
  title = Book.arel_table[:title]
  @book_search = Book.where(title.matches("%#{input_title}%"))
  @book = params[:book_selected]
  erb :booklist
end

get "/bookabout#{@book}" do
  @book = params[:book_selected]
  @book_found = Book.find_by(title: @book)
  @user = current_user
  erb :bookabout
end

post "/bookshelf" do
  @user = current_user
  Shelf.create(book_id: params[:book_id], user_id: params[:user_id])
  @usershelf = params[:user_id]
  redirect "/bookshelf"
end
get "/bookshelf" do
  @usershelf = Shelf.where(user_id: current_user)

  erb :bookshelf
end
