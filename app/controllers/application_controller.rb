require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'runners/create_runner'
  end

  post '/signup' do
    redirect to '/login'
  end

  get '/login' do
    erb :'runners/login'
  end

  post '/login' do
    redirect to '/login'
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find_by_id(session[:id])
    end
  end

end
