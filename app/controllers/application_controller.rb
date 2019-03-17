require './config/environment'
require 'pry'

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
  if User.find_by(email: params["email"])
    erb :'/users/alreadyexists'
  else
  @user = User.new(name: params["name"], email: params["email"], password_digest: params["password"])
  if @user.save
    session[:user_id] = @user.id
    redirect '/users/home'
  else
    @error = "Make sure to fill out all fields."
    redirect '/registrations/signup'
  end
end

  end

  get '/newplayer' do
    redirect_if_not_logged_in
    #@user = User.find_by_id(session[:user_id])
    #if @user
      erb  :'/players/new'
    #end

  end

  get '/viewplayers' do
    redirect_if_not_logged_in
      @user = User.find_by_id(session[:user_id])
      if @user
        @player = Player.all.select {|player| player.user_id == session[:user_id]}
        erb :'/players/all'
      end

  end

  post '/newplayer' do
    unless Player.valid_params?(params)
       redirect to "/newplayer?error=Invalid player values! Please try again."
    end
    @player = Player.create(params)
    @player.user_id = session[:user_id]
    @player.save
    redirect to '/viewplayers'
  end

  get '/sessions/login' do
    erb :'/sessions/login'
  end

  post '/sessions' do
  @user = User.find_by(email: params["email"], password_digest: params["password"])
    if @user
      session[:user_id] = @user.id
      redirect '/viewplayers'
    else
    redirect '/sessions/login?error=Please check your login credentials.'
    end

  end

  get '/players/show/:id' do
    redirect_if_not_logged_in
    @player = Player.find_by(id: params[:id])
    erb :'/players/show'
  end

  get '/players/edit/:id' do
    redirect_if_not_logged_in
    @player = Player.find(params[:id])
    erb :'/players/edit'
  end

  patch '/players/:id' do
  @player = Player.find(params[:id])
  unless Player.valid_params?(params)
     redirect to "/players/edit/#{@player.id}?error=Invalid player values! Please try again."
  end
  @player.update(name: params[:name], position: params[:position])
  redirect to "/players/show/#{ @player.id }"
  end

  delete '/players/delete/:id' do
   Player.destroy(params[:id])
   redirect to "/viewplayers"
  end

  get '/users/home' do
     @user = User.find_by_id(session[:user_id])
     @player = Player.all.select {|player| player.user_id == session[:user_id]}
    erb :'/users/home'
  end

 get '/sessions/logout' do
   session.clear
   redirect '/'
 end


  helpers do
    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/sessions/login?error=You have to be logged in to do that..."
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end

end
