class StudentsController < ApplicationController
  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      session[:email] = @student.email
      redirect_to login_path,
        notice: 'Student was successfully created.'
    else
      render :new
    end
  end

  def show
    @student = Student.find(params[:id])
  end

  def edit
    @student = Student.find(params[:id])
  end

  private

  def student_params
    params.require(:student).permit(
      :email,
      :first_name,
      :last_name,
      :password,
      :password_confirmation
    )
  end
end
