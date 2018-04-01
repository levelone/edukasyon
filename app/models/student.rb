class Student < ApplicationRecord
  include ActiveModel::AttributeAssignment
  attr_accessor :full_name

  has_many :klasses
  has_many :teachers, through: :klasses
  has_secure_password

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
  validates :password, presence: true, :length => { in: 6..20 }

  def full_name
    "#{first_name} #{last_name}"
  end

  # find better solution to move
  # this method to klass.rb instead
  def klasses_for_enrollment
    klass_ids = []
    student_klasses = klasses.pluck(:subject, :teacher_id)
    student_klasses.each do |sk|
      klass_ids <<
        Klass.offered_klasses.find_by(
          subject: sk.first,
          teacher_id: sk.last
        ).id
    end

    Klass.offered_klasses.where.not(id: klass_ids)
  end
end
