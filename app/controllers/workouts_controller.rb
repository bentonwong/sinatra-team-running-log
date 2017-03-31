require './config/environment'
require 'pry'

class WorkoutsController < ApplicationController

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/workouts' do
    logged_in? ? (redirect to "/workouts/log/#{current_user.id}") : (redirect to '/login')
  end

  get '/workouts/log/:runner_id' do
    @runner = find_runner_by_id(params[:runner_id])
    @workouts = Workout.where("runner_id = ?", @runner.id).order("workout_date DESC")
    @new_workout_button = "<button type='button'><a href='/workouts/new' style='text-decoration:none'>Log New Workout</a></button>" if session[:id] == @runner.id
    logged_in? ? (erb :'workouts/log') : (redirect to '/login')
  end

  get '/workouts/new' do
    logged_in? ? (erb :'workouts/create_workout') : (redirect to '/login')
  end

  post '/workouts' do
    if logged_in? && (current_user.id == session[:id])
      if params[:distance].blank? && params[:workout_date].blank?
        redirect to '/workouts/new'
      else
        params[:runner_id] = current_user.id
        @runner = Workout.create(params)
        redirect to "/workouts/log/#{current_user.id}"
      end
    else
      redirect to '/'
    end
  end

  get '/workouts/:id' do
    if logged_in? && (current_user.id == session[:id])
      @workout = find_workout_by_id(params[:id])
      @runner = find_runner_by_id(@workout.runner_id)
      if session[:id] == @runner.id
        @edit_workout_button = "<button type='button'><a href='/workouts/#{@workout.id}/edit' style='text-decoration:none'>Edit Workout</a></button>" if session[:id] == @runner.id
        @delete_workout_button = "<form action='/workouts/#{@workout.id}/delete' method='post'><input id='hidden' type='hidden' name='_method' value='delete'><input type='submit' value='Delete Workout'>"
      end
      @notes_label = "Notes: " if !@workout.notes.blank?
      !!@workout ? (erb :'workouts/show_workout') : (redirect to '/workouts')
    else
      redirect to '/login'
    end
  end

  get '/workouts/:id/edit' do
    @workout = find_workout_by_id(params[:id])
    if logged_in?
      if current_user.id == @workout.runner_id
        !!@workout ? (erb :'workouts/edit_workout') : (redirect to '/workouts')
      else
        redirect to '/workouts'
      end
    else
      redirect to '/login'
    end
  end

  patch '/workouts/:id' do
    if params[:distance].strip.empty?
      redirect to "/workouts/#{params[:id]}/edit"
    else
      if !!find_workout_by_id(params[:id])
        @workout = find_workout_by_id(params[:id])
        @workout.update_attributes(:distance => params[:distance],:workout_date => params[:workout_date],:notes => params[:notes]) if current_user.id == @workout.runner_id
      end
      redirect to "/workouts/#{@workout.id}"
    end
  end

  delete '/workouts/:id/delete' do
    @workout = find_workout_by_id(params[:id])
    if logged_in? && current_user.id == @workout.runner_id
      @workout.delete
    end
    redirect to '/workouts'
  end

  get '/leaderboard' do
    @time_periods = ["This Month", "This Year" , "All Time"]
    @genders = ["male","female"]
    @current_time = Time.now
    erb :'workouts/leaderboard'
  end

end
