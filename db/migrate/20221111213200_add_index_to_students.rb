class AddIndexToStudents < ActiveRecord::Migration[6.1]
  def change
    add_index :students, :uni, unique: true
  end
end
