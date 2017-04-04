require './config/environment'
require 'pry'
require 'date'

class RunnersController < ApplicationController

  get '/signup' do
    redirect to "/workouts/#{session[:id]}" if logged_in?
    @runner = Runner.new
    erb :'runners/create_runner'
  end

  post '/signup' do
    @runner = Runner.new(params)
    if @runner.save
      session[:id] = runner.id
      redirect to "/workouts/#{current_user.id}"
    else
      erb :'runners/create_runner'
    end
  end

  get '/login' do
    !logged_in? ? (erb :'runners/login') : (redirect to "/workouts")
  end

  post '/login' do
    @runner = Runner.find_by(email: params["email"])
    if !!@runner && @runner.authenticate(params[:password])
     session[:id] = @runner.id
     redirect to "/workouts"
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
