class AddCourseToKlasses < ActiveRecord::Migration[5.1]
  def change
    add_reference :klasses, :course, foreign_key: true
  end
end
