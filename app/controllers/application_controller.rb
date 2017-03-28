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

  get '/workouts' do
    @runner = current_user if logged_in?
    logged_in? ? (erb :'workouts/workouts') : (redirect to '/login')
  end

  get '/workouts/new' do
    logged_in? ? (erb :'workouts/create_workout') : (redirect to '/login')
  end

  post '/workouts' do
    if logged_in? && (current_user.id == session[:id])
      if params[:distance].strip.empty?
        redirect to '/workouts/new'
      else
        params[:runner_id] = current_user.id
        @runner = Workout.create(params)
        redirect to '/workouts'
      end
    else
      redirect to '/'
    end
  end

  get '/workouts/:id' do
    if logged_in? && (current_user.id == session[:id])
      @workout = Workout.find_by_id(params[:id])
      !!@workout ? (erb :'workouts/show_workout') : (redirect to '/workouts')
      erb :'workouts/show_workout'
    else
      redirect to '/login'
    end
  end

  get '/signup' do
    !logged_in? ? (erb :'runners/create_runner') : (redirect to '/workouts')
  end

  post '/signup' do
    if !params.values.any? {|value| value.empty?}
      runner = Runner.create(params)
      session[:id] = runner.id
      redirect to '/workouts'
    else
      redirect to '/signup'
    end
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
      Runner.find_by_id(session[:id])
    end
  end

end
