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

  get "/" do
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

  get '/users/home' do
     @user = User.find(session[:user_id])
    erb :'/users/home'
  end





  get '/new-user' do
    erb :new_user
  end

end
