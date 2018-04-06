class Klass < ApplicationRecord
  belongs_to :review, optional: true
  belongs_to :student, optional: true
  belongs_to :teacher
  belongs_to :course

  validates_uniqueness_of :teacher_id,  scope: [:course_id, :student_id]
  after_destroy :unenroll_students, if: :klass_without_teacher?

  scope :order_by_course, -> (direction = 'asc') { includes(:course).order("courses.name #{direction}") }
  scope :offered_klasses, -> { where(student_id: nil).order_by_course }

  scope :search, -> (term = nil) do
    if term.present?
      includes(:course).where('LOWER(courses.name) LIKE ?', "%#{term.downcase}%")
    else
      order_by_course
    end
  end

  def klass_students
    Klass.
      where(course_id: course_id, teacher_id: teacher_id).
      where.not(student_id: nil)
  end

  def klass_reviews
    Klass.
      where(course_id: course_id, teacher_id: teacher_id).
      where.not(student_id: nil, review_id: nil)
  end

  def klass_rating
    ratings = klass_reviews.map { |kr| kr.review.rating }
    result = ratings.inject(0.0) { |sum, el| sum + el } / ratings.size
    result.round(2)
  end

  private

  def klass_without_teacher?
    student_id.nil?
  end

  def unenroll_students
    Klass.where(
      course_id: course_id,
      teacher_id: teacher_id
    ).destroy_all
  end
end
