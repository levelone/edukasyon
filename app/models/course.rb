class Course < ApplicationRecord
  has_many :klasses, dependent: :destroy
  has_many :teachers, through: :klasses
  has_many :students, through: :klasses

  validates :name, presence: true, uniqueness: true

  scope :search, -> (term = nil) do
    if term
      where('LOWER(courses.name) LIKE ?', "%#{term.downcase}%")
    else
      order(:name)
    end
  end
end
