require './config/environment'
require 'pry'

class WorkoutsController < ApplicationController

  get '/workouts/runner/:id' do
    redirect to '/login' if !logged_in?
    @runner = Runner.find_by_id(params[:id])
    if @runner
      @workouts = Workout.all_workouts_by_runner_id_rev_chron(@runner.id)
    else
      @runner = current_user
    end
    erb :'workouts/workouts'
  end

  get '/workouts/new' do
    logged_in? ? (erb :'workouts/create_workout') : (redirect to '/login')
  end

  post '/workouts' do
    current_user.workouts.create(params)
    redirect to '/workouts/runner/#{current_user.id}'
  end

  get '/workouts/:workout_id' do
    redirect to '/login' if !logged_in?
    @workout = Workout.find_by_id(params[:workout_id])
    redirect to '/workouts' if !@workout
    @runner = Runner.find_by_id(@workout.runner_id)
    @notes_label = "Notes: " if !@workout.notes.blank?

    if current_user == @workout.runner
      @edit_workout_button = "<button type='button'><a href='/workouts/#{@workout.id}/edit' style='text-decoration:none'>Edit Workout</a></button>"
      @delete_workout_button = "<form action='/workouts/#{@workout.id}' method='post'><input id='hidden' type='hidden' name='_method' value='delete'><input type='submit' value='Delete Workout'>"
    end

    erb :'workouts/show_workout'
  end

  get '/workouts/:workout_id/edit' do
    redirect to '/login' if !logged_in?
    @workout = Workout.find_by_id(params[:workout_id])
    if !!@workout
      current_user.id == @workout.runner_id ? (erb :'workouts/edit_workout') : (redirect to '/workouts')
    else
      redirect to '/workouts/runner/#{current_user.id}'
    end
  end

  patch '/workouts/:workout_id' do
    redirect to '/login' if !logged_in?
    @workout = Workout.find_by_id(params[:workout_id])
    if !!@workout && current_user.id == @workout.runner_id
      @workout.update_attributes(:distance => params[:distance],:workout_date => params[:workout_date],:notes => params[:notes])
    end
    redirect to '/workouts/runner/#{current_user.id}'
  end

  delete '/workouts/:workout_id' do
    redirect to '/login' if !logged_in?
    @workout = Workout.find_by_id(params[:workout_id])
    @workout.delete if current_user.id == @workout.runner_id && !!@workout
    redirect to '/workouts/runner/#{current_user.id}'
  end

end
