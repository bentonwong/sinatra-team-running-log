module Helpers

  def logged_in?
    !!session[:id]
  end

  def current_user
    Runner.find_by_id(session[:id])
  end

  def rankings(gender,period)
    total_mileage = {}

    case period
      when "this year"
        Runner.all.select{|runner| runner[:gender] == gender}.each do |runner|
          total_mileage[runner.id] = Workout.all.select{|w| w.runner_id == runner.id && Time.now.beginning_of_year <= w.workout_date}.map{|workout| workout.distance}.sum
        end
      when "this month"
        Runner.all.select{|runner| runner[:gender] == gender}.each do |runner|
          total_mileage[runner.id] = Workout.all.select{|w| w.runner_id == runner.id && Time.now.beginning_of_month <= w.workout_date}.map{|workout| workout.distance}.sum
        end
      when "all time"
        Runner.all.select{|runner| runner[:gender] == gender}.each do |runner|
          total_mileage[runner.id] = Workout.all.select{|w| w.runner_id == runner.id}.map{|workout| workout.distance}.sum
        end
    end
    total_mileage.sort_by{|runner_id, mileage| mileage}.reverse
  end

  def rankings2(gender,period)
    total_mileage_by_runner_id = Hash.new(0)
    case period
      when period = "all time"
        restriction = "'gender = ?',gender"
      when period = "this year"
        restriction = "'gender = ? and workout_date >= ?',gender,Time.now.beginning_of_year"
      when period = "this month"
        restriction = "'gender = ? and workout_date >= ?',gender,Time.now.beginning_of_month"
    end
    query_results = Workout.where("#{restriction}").joins("INNER JOIN runners ON runners.id = workouts.runner_id")
    query_results.each do |workout|
      total_mileage_by_runner_id[workout.runner_id] += workout.distance
    end
  end



end
