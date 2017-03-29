require 'pry'

module Helpers

  def logged_in?
    !!session[:id]
  end

  def current_user
    Runner.find_by_id(session[:id])
  end

  def rankings(gender,period)
    total_mileage_by_runner_id = Hash.new(0)
    case period
      when "All Time"
        query_results = Workout.where("gender = ?", gender).joins("INNER JOIN runners ON runners.id = workouts.runner_id")
      when "This Year"
        query_results = Workout.where("gender = ? AND workout_date >= ?", gender, Time.now.beginning_of_year).joins("INNER JOIN runners ON runners.id = workouts.runner_id")
      when "This Month"
        query_results = Workout.where("gender = ? AND workout_date >?", gender, Time.now.beginning_of_month).joins("INNER JOIN runners ON runners.id = workouts.runner_id")
    end
    query_results.each do |workout|
      total_mileage_by_runner_id[workout.runner_id] += workout.distance
    end
    total_mileage_by_runner_id.sort_by{|runner_id, mileage| mileage}.reverse
  end

end
