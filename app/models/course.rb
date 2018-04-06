class Course < ApplicationRecord
  has_many :klasses, dependent: :destroy
  has_many :teachers, through: :klasses
  has_many :students, through: :klasses

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :image_url, presence: true

  scope :search, -> (term = nil) do
    if term.present?
      where('LOWER(courses.name) LIKE ?', "%#{term.downcase}%")
    else
      order(:name)
    end
  end

  LOCAL_IMAGE_URLS = %w(
    black.jpg blue.jpg green.jpg
    orange.jpg teal.jpg yellow.jpg
    white.jpg red.jpg navy.jpg grey.jpg
  ).freeze

end
