class KlassesController < ApplicationController
  def show
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
  end

  def enroll
    klass = Klass.find(params[:id])
    new_klass = Klass.new(
      teacher_id: klass.teacher_id,
      course_id: klass.course_id,
      student_id: current_user.id
    )
    new_klass.save!
    redirect_to request.referrer
  end

  def unenroll
    klass = Klass.find(params[:id])
    klass_student = Klass.find_by(
      student_id: current_user.id,
      course_id: klass.course_id
    )
    klass_student.destroy
    redirect_to request.referrer
  end
end
