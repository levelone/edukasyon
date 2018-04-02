class CoursesController < ApplicationController
  def index
    @courses = Course.search(params[:q])
  end

  def show
    @course = Course.find(params[:id])
  end
end
