module Helpers

  def logged_in?
    !!session[:id]
  end

  def current_user
    Runner.find_by_id(session[:id])
  end

end
