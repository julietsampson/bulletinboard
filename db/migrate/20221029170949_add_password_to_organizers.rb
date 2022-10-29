class AddPasswordToOrganizers < ActiveRecord::Migration
  def change
    add_column :organizers, :password, :string
  end
end
