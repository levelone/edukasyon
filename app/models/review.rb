class Review < ApplicationRecord
  has_one :klass
  has_one :student, through: :klass
  has_one :teacher, through: :klass

  RATING_SYSTEM = Array(1..5).freeze
end
