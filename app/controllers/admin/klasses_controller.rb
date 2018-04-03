class Admin::KlassesController < ApplicationController
  def index
    @klasses = Klass.search(params[:q])
  end

  def show
    @klass = Klass.find(params[:id])
    @klass_students = Student.find(@klass.klass_students.map(&:student_id))
  end

  def new
    @klass = Klass.new
    @teachers = Teacher.order(:first_name)
    @students = Student.order(:first_name)
    @courses = Course.order(:name)
  end

  def edit
    @klass = Klass.find(params[:id])
    @teachers = Teacher.order(:first_name)
    @students = Student.order(:first_name)
    @courses = Course.order(:name)
  end

  def create
    @klass = Klass.new(klass_params)
    @teachers = Teacher.order(:first_name)
    @courses = Course.order(:name)

    if @klass.save
      redirect_to admin_klasses_path(@klass),
        notice: 'Klass was successfully created.'
    else
      render :new
    end
  end

  def update
    @klass = Klass.find(params[:id])
    @courses = Course.order(:name)
    @teachers = Teacher.order(:first_name)

    if @klass.update(klass_params)
      redirect_to admin_klasses_path(@klass),
        notice: 'Klass was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @klass = Klass.find(params[:id])
    @klass.destroy
    redirect_to admin_klasses_url,
      notice: 'Klass was successfully destroyed.'
  end

  def enroll
    klass = Klass.find(params[:id])
    new_klass = Klass.new(
      teacher_id: klass.teacher_id,
      course_id: params[:course_id],
      student_id: params[:student_id]
    )
    new_klass.save!
    redirect_to request.referrer
  end

  def unenroll
    klass = Klass.find(params[:id])
    klass = Klass.find_by(
      student_id: klass.student_id,
      course_id: klass.course_id
    )
    klass.destroy
    redirect_to request.referrer
  end

  private

  def klass_params
    params.require(:klass).permit(
      :subject,
      :teacher_id,
      :student_id,
      :course_id,
      :q
    )
  end
end
