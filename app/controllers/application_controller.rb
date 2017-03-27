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

  get '/workout' do
    erb :'workouts/workouts'
  end

  get '/signup' do
    erb :'runners/create_runner'
  end

  post '/signup' do
    redirect to '/login'
  end

  get '/login' do
    !logged_in? ? (erb :'runners/login') : (redirect to '/workouts')
  end

  post '/login' do
    @runner = Runner.find_by(email: params["email"])
   if !!@runner && @runner.authenticate(params[:password])
     session[:id] = @runner.id
     redirect to '/workouts'
   else
     redirect to '/login'
   end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
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
