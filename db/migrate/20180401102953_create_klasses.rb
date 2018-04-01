class CreateKlasses < ActiveRecord::Migration[5.1]
  def change
    create_table :klasses do |t|
      t.string :subject
      t.references :student, foreign_key: true
      t.references :teacher, foreign_key: true

      t.timestamps
    end
  end
end
