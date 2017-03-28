require './config/environment'
require 'pry'

class WorkoutsController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
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
    else
      redirect to '/login'
    end
  end

  get '/workouts/:id/edit' do
    "hello"
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
