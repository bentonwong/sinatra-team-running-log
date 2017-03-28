require './config/environment'
require 'pry'

class RunnersController < ApplicationController

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/signup' do
    !logged_in? ? (erb :'runners/create_runner') : (redirect to '/workouts')
  end

  post '/signup' do
    if !params.values.any? {|value| value.empty?} && !Runner.find_by_email(params["email"])
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

end
