class Admin::TeachersController < ApplicationController
  def index
    @teachers = Teacher.all
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  def new
    @teacher = Teacher.new
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      redirect_to admin_teacher_path(@teacher),
        notice: 'Teacher was successfully created.'
    else
      render :new
    end
  end

  def update
    @teacher = Teacher.find(params[:id])
    if @teacher.update(teacher_params)
      redirect_to admin_teacher_path(@teacher),
        notice: 'Teacher was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    redirect_to admin_teachers_url,
      notice: 'Teacher was successfully destroyed.'
  end

  private

  def teacher_params
    params.require(:teacher).permit(
      :email,
      :first_name,
      :last_name,
      :password,
      :password_confirmation
    )
  end
end
