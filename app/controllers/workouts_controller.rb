require './config/environment'
require 'pry'

class WorkoutsController < ApplicationController

  get '/workouts' do
    redirect to "/workouts/runner/#{current_user.id}"
  end

  get '/workouts/runner/:id' do
    @runner = Runner.find_by_id(params[:id])
    @workouts = Workout.all_workouts_by_runner_id_rev_chron(@runner.id)
    logged_in? ? (erb :'workouts/workouts') : (redirect to '/login')
  end

  get '/workouts/new' do
    logged_in? ? (erb :'workouts/create_workout') : (redirect to '/login')
  end

  post '/workouts' do
    if logged_in? && (current_user.id == session[:id])
      if params[:distance].blank? || params[:workout_date].blank?
        redirect to '/workouts/new'
      else
        params[:runner_id] = current_user.id
        @runner = Workout.create(params)
        redirect to "/workouts"
      end
    else
      redirect to '/login'
    end
  end

  get '/workouts/:workout_id' do
    if logged_in?
      @workout = Workout.find_by_id(params[:workout_id])
      @runner = Runner.find_by_id(@workout.runner_id)
      if current_user.id == @workout.runner_id
        @edit_workout_button = "<button type='button'><a href='/workouts/#{@workout.id}/edit' style='text-decoration:none'>Edit Workout</a></button>" if session[:id] == @runner.id
        @delete_workout_button = "<form action='/workouts/#{@workout.id}' method='post'><input id='hidden' type='hidden' name='_method' value='delete'><input type='submit' value='Delete Workout'>"
      end
      @notes_label = "Notes: " if !@workout.notes.blank?
      !!@workout ? (erb :'workouts/show_workout') : (redirect to "/workouts")
    else
      redirect to '/login'
    end
  end

  get '/workouts/:workout_id/edit' do
    @workout = Workout.find_by_id(params[:workout_id])
    if logged_in?
      if current_user.id == @workout.runner_id
        !!@workout ? (erb :'workouts/edit_workout') : (redirect to '/workouts')
      else
        redirect to "/workouts"
      end
    else
      redirect to '/login'
    end
  end

  patch '/workouts/:workout_id' do
    if params[:distance].strip.blank? || params[:workout_date].strip.blank?
      redirect to "/workouts/#{params[:workout_id]}/edit"
    else
      if !!Workout.find_by_id(params[:workout_id])
        @workout = Workout.find_by_id(params[:workout_id])
        @workout.update_attributes(:distance => params[:distance],:workout_date => params[:workout_date],:notes => params[:notes]) if current_user.id == @workout.runner_id
      end
      redirect to "/workouts"
    end
  end

  delete '/workouts/:workout_id' do
    @workout = Workout.find_by_id(params[:workout_id])
    @workout.delete if logged_in? && current_user.id == @workout.runner_id
    redirect to "/workouts"
  end

end
