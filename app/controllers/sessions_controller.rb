class SessionsController < ApplicationController
  # before_action :require_logout, only: [:new, :create]

  def new
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]
    student = Student.find_by(email: email)

    if student && student.authenticate(password)
      session[:email] = nil
      session[:student_id] = student.id
      current_user
      redirect_to root_path
    else
      session[:email] = params[:session][:email]
      @error = build_error_message(student)
      render 'new'
    end
  end

  def destroy
    current_user = nil
    session[:student_id] = nil
    redirect_to root_path
  end

  private

  def build_error_message(user)
    email = params[:session][:email]
    password = params[:session][:password]

    if user.present?
      'Password is incorrect!'
    elsif email.blank? || password.blank?
      'Email or Password is blank!'
    else
      'Email does not exist'
    end
  end
end
