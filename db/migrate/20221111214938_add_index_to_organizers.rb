class AddIndexToOrganizers < ActiveRecord::Migration[6.1]
  def change
    add_index :organizers, :email, unique: true
    change_column_null :organizers, :email, false, 1
    change_column_null :students, :uni, false, 1
    change_column_null :organizers, :password, false, 1
    change_column_null :students, :password, false, 1
  end
end
