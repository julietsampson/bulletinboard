class AddPasswordToOrganizers < ActiveRecord::Migration[6.1]
  def change
    add_column :organizers, :password, :text
  end
end
