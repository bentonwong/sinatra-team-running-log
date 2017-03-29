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
        start_date = 0
      when "This Year"
        start_date = Time.now.beginning_of_year
      when "This Month"
        start_date = Time.now.beginning_of_month
    end

    query_results = Workout.where("gender = ? AND workout_date >= ?", gender, start_date).joins("INNER JOIN runners ON runners.id = workouts.runner_id") #returns the requested workouts matching conditions

    query_results.each do |workout| #sums up the mileage by runner_id and puts it into a hash
      total_mileage_by_runner_id[workout.runner_id] += workout.distance
    end

    total_mileage_by_runner_id.sort_by{|runner_id, mileage| mileage}.reverse #sorts the hash by mileage and puts it into an array
  end

end
