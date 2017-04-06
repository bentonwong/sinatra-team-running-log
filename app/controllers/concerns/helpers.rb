require 'pry'

module Helpers

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= Runner.find_by_id(session[:id])
  end

  def rankings(gender,period)
    Workout.rankings(gender,period)
  end

end
