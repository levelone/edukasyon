class Admin::StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
  end

  def new
    @student = Student.new
  end

  def edit
    @student = Student.find(params[:id])
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to admin_student_path(@student),
        notice: 'Student was successfully created.'
    else
      render :new
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      redirect_to admin_student_path(@student),
        notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to admin_students_url,
      notice: 'Student was successfully destroyed.'
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
