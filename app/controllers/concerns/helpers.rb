require 'pry'

module Helpers

  def logged_in?
    !!session[:id]
  end

  def current_user
    Runner.find_by_id(session[:id])
  end

  def find_runner_by_id(id)
    Runner.find_by_id(id)
  end

  def find_workout_by_id(id)
    Workout.find_by_id(id)
  end

  def rankings(gender,period)
    Workout.rankings(gender,period)
  end

end
