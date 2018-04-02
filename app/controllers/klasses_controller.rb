class KlassesController < ApplicationController
  def show
    @klass = Klass.find(params[:id])
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
    klass = Klass.find_by(
      student_id: current_user.id,
      course_id: klass.course_id
    )
    klass.destroy
    redirect_to request.referrer
  end
end
