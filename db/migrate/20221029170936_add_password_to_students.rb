class AddPasswordToStudents < ActiveRecord::Migration[6.1.2]
  def change
    add_column :students, :password, :text
  end
end
