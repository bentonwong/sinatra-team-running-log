require './config/environment'
require 'pry'
require 'sinatra'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  helpers Helpers

  get '/' do
    logged_in? ? (redirect to "/workouts/runner/#{current_user.id}") : (erb :index)
  end

  get '/leaderboard' do
    @time_periods = ["This Month", "This Year" , "All Time"]
    @genders = ["male","female"]
    @current_time = Time.now
    erb :leaderboard
  end

end
