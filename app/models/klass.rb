class Klass < ApplicationRecord
  belongs_to :student, optional: true
  belongs_to :teacher
  after_destroy :unenroll_students, if: :klass_teacher_unavailable?

  scope :offered_klasses, -> do
    where(student_id: nil).order(:subject)
  end

  def enrolled_students
    student_ids =
      Klass.
        where(subject: subject, teacher_id: teacher_id).
        where.not(student_id: nil).
        pluck(:student_id)

    Student.find(student_ids)
  end

  def klass_teacher_available?
    student_id.present?
  end

  def klass_teacher_unavailable?
    !klass_teacher_available?
  end

  private

  def unenroll_students
    Klass.where(
      subject: subject,
      teacher_id: teacher_id
    ).destroy_all
  end
end
