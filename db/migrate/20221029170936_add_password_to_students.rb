class AddPasswordToStudents < ActiveRecord::Migration
  def change
    add_column :students, :password, :text
  end
end
