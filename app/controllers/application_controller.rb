class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :current_uri

  private

  def current_uri
    request.env['PATH_INFO']
  end

  def current_user
    @current_user ||= Student.find_by_id(session[:student_id])
  end
end
