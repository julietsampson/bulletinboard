class CreateEventsStudentsJoinTable < ActiveRecord::Migration[6.1.2]
  def change
    create_join_table :students, :events do |t|
      t.index :student_id
      t.index :event_id
    end
  end
end
