class AddGenderAndImageUrlToTeachers < ActiveRecord::Migration[5.1]
  def change
    add_column :teachers, :gender, :string
    add_column :teachers, :image_url, :string
  end
end
