class RemoveSubjectFromKlasses < ActiveRecord::Migration[5.1]
  def change
    remove_column :klasses, :subject, :string
  end
end
