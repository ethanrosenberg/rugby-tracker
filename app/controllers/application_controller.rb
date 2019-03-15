require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, "thisisnotsecure"
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    #erb :welcome
    erb :index
  end

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/registrations' do
  puts params
  @user = User.new(name: params["name"], email: params["email"], password: params["password"])
  @user.save
  session[:user_id] = @user.id
  redirect '/users/home'
  end

  get '/sessions/login' do
    erb :'/sessions/login'
  end

  post '/sessions' do
  @user = User.find_by(email: params["email"], password: params["password"])
  session[:user_id] = @user.id
    if @user
      session[:user_id] = @user.id
      redirect '/users/home'
    end
    redirect '/sessions/login'

  end

  get '/users/home' do
     @user = User.find(session[:user_id])
    erb :'/users/home'
  end

 get '/sessions/logout' do
   session.clear
   redirect '/'
 end



  get '/new-user' do
    erb :new_user
  end

end
