class Admin::CoursesController < ApplicationController
  def index
    @courses = Course.search(params[:q])
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def edit
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to admin_course_path(@course),
        notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to admin_course_path(@course),
        notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to admin_courses_url,
      notice: 'Course was successfully destroyed.'
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end
end
