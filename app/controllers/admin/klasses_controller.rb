class Admin::KlassesController < ApplicationController
  def index
    @klasses = Klass.order(:subject)
  end

  def show
    @klass = Klass.find(params[:id])
  end

  def new
    @klass = Klass.new
    @teachers = Teacher.order(:first_name)
    @students = Student.order(:first_name)
  end

  def edit
    @klass = Klass.find(params[:id])
    @teachers = Teacher.order(:first_name)
    @students = Student.order(:first_name)
  end

  def create
    @klass = Klass.new(klass_params)
    if @klass.save
      redirect_to admin_klasses_path(@klass),
        notice: 'Klass was successfully created.'
    else
      render :new
    end
  end

  def update
    @klass = Klass.find(params[:id])
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
      subject: klass.subject,
      teacher_id: klass.teacher_id,
      student_id: params[:student_id]
    )
    new_klass.save!
    redirect_to request.referrer
  end

  def unenroll
    klass = Klass.find(params[:id])
    klass.destroy
    redirect_to request.referrer
  end

  private

  def klass_params
    params.require(:klass).permit(:subject, :teacher_id, :student_id)
  end
end
