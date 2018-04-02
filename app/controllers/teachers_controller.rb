class TeachersController < ApplicationController
  def index
    @teachers = Teacher.search(params[:q])
  end

  def show
    @teacher = Teacher.find(params[:id])
  end
end
