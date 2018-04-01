class Teacher < ApplicationRecord
  include ActiveModel::AttributeAssignment
  attr_accessor :full_name

  has_many :klasses, dependent: :destroy
  has_many :students, through: :klasses
  has_secure_password

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
  validates :password, presence: true, :length => { in: 6..20 }

  def full_name
    "#{first_name} #{last_name}"
  end
end
