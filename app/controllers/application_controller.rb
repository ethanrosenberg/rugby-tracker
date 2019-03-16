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
  if User.find_by(email: params["email"])
    erb :'/users/alreadyexists'
  else
  @user = User.new(name: params["name"], email: params["email"], password: params["password"])
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
    @user = User.find_by_id(session[:user_id])
    if @user
      erb  :'/players/new'
    else
      @error = "You must login to add a new player."
      erb :'/sessions/login'
    end

  end

  get '/viewplayers' do
    @user = User.find_by_id(session[:user_id])
    if @user
      @player = Player.all.select {|player| player.user_id == session[:user_id]}
      erb :'/players/all'
    else
      #message = "You must be logged in."
      #redirect to ("/sessions/login?error=#{message}")
      #erb :'/users/notloggedin'
      @error = "You must login to view a team roster."
      erb :'/sessions/login'
      #redirect to ("/sessions/login?error=You must be logged in.")
    end


  end

  post '/newplayer' do
    unless Player.valid_params?(params)
       redirect to "/newplayer?error=Invalid player values! Please try again."
    end
    @player = Player.create(params)
    #@user = User.find_by_id(session[:user_id])
    @player.user_id = session[:user_id]
    @player.save

    redirect to '/users/home'
  end

  get '/sessions/login' do
    erb :'/sessions/login'
  end

  post '/sessions' do
  @user = User.find_by(email: params["email"], password: params["password"])
    if @user && user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/viewplayers'
    else
    @error = "Please login to continue."
    redirect '/sessions/login'
    end

  end

  get '/players/show/:id' do
    @player = Player.find_by(id: params[:id])
    erb :'/players/show'
  end

  get '/players/edit/:id' do
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



  get '/new-user' do
    erb :new_user
  end

  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end

	end

end
