class AddTagsToStudents < ActiveRecord::Migration[6.1]
  def change
    add_column :students, :tags, :text, array: true
  end
end
