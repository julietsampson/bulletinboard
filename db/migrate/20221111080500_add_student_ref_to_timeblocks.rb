class AddStudentRefToTimeblocks < ActiveRecord::Migration[6.1]
  def change
    add_reference :timeblocks, :student, foreign_key: true
  end
end
