module Helper

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
      time_period = "&& Time.now.beginning_of_year <= Date.parse('w.workout_date')"
    when "this month"
      time_period = "&& Time.now.beginning_of_month <= Date.parse('w.workout_date')"
    else
      time_period = ""
    end
    Runner.all.select{|r| r[:gender] == gender}.each do |runner|
      total_mileage[runner.id] = Workout.all.select{|w| w.runner_id == runner.id && Time.now.beginning_of_month <= Date.parse('w.workout_date')}.map{|workout| workout.distance}.sum
    end
    total_mileage.sort_by{|runner_id, mileage| mileage}.reverse
  end

end
