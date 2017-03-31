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
    case period
      when "All Time"
        start_date = 0
      when "This Year"
        start_date = Time.now.beginning_of_year
      when "This Month"
        start_date = Time.now.beginning_of_month
    end
    query_results = Workout.where("gender = ? AND workout_date >= ?", gender, start_date).joins("INNER JOIN runners ON runners.id = workouts.runner_id")
    format_query_results_into_rankings(query_results)
  end

  def format_query_results_into_rankings(query_results)
    total_mileage_by_runner_id = Hash.new(0)
    query_results.each{|workout| total_mileage_by_runner_id[workout.runner_id] += workout.distance}
    total_mileage_by_runner = total_mileage_by_runner_id.sort_by{|runner_id, mileage| mileage}.reverse
    total_mileage_by_runner.collect{|runner_data| runner_data.insert(1,find_runner_by_id(runner_data[0]).name)}
  end

end
