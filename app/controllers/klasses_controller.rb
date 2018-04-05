class KlassesController < ApplicationController
  def show
    @review = Review.new
    @klass = Klass.find(params[:id])
    @klass_students = Student.find(@klass.klass_students.map(&:student_id))
    @klass_reviews = Review.find(@klass.klass_reviews.pluck(:review_id))

    if current_user.present?
      @is_klass_student = @klass_students.find do |s|
        s.id == current_user.id
      end

      @has_klass_review = @klass_reviews.find do |r|
        current_user.reviews.map(&:id).include?(r.id)
      end
    end

    respond_to do |format|
      format.html
      format.json { render json: { klass: @klass, rating: @klass.klass_rating } }
    end
  end

  def enroll
    klass = Klass.find(params[:id])
    Klass.new(
      student_id: current_user.id,
      course_id: klass.course_id,
      teacher_id: klass.teacher_id
    ).save!
    redirect_to request.referrer
  end

  def unenroll
    klass = Klass.find(params[:id])
    Klass.find_by(
      student_id: current_user.id,
      course_id: klass.course_id,
      teacher_id: klass.teacher_id
    ).destroy
    redirect_to request.referrer
  end
end
