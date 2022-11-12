class AddDefaultTagToStudents < ActiveRecord::Migration[6.1]
  def change
    change_column_default :students, :tags, []
  end
end
