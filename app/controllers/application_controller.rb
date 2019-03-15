require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    #erb :welcome
    erb :index
  end

  get '/new-user' do
    erb :new_user
  end

end
