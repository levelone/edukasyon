class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    klass = Klass.find(params[:klass_id])
    klass_student = current_user.klasses.find_by(
      course_id: klass.course_id,
      teacher_id: klass.teacher_id
    )

    if klass_student.present? && @review.save
      klass_student.review_id = @review.id
      klass_student.save!
      redirect_to klass_path(klass)
    else
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(
      :description,
      :rating
    )
  end
end
