class AddPasswordToOrganizers < ActiveRecord::Migration
  def change
    add_column :organizers, :password, :text
  end
end
