class TeachersController < ApplicationController
  def index
    @teachers = Teacher.search(params[:q])
  end

  def show
    @teacher = Teacher.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: { rating: @teacher.klass_average_rating } }
    end
  end
end
