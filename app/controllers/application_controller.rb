class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def current_user
    @current_user ||= Student.find_by_id(session[:student_id])
  end
end
