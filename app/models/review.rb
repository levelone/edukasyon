class Review < ApplicationRecord
  has_many :klasses
  has_many :students, through: :klasses

  RATING_SYSTEM = Array(1..5).freeze
end
