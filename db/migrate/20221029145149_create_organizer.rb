class CreateOrganizer < ActiveRecord::Migration
  def change
    create_table :organizers do |t|
      t.string :name
      t.string :email, unique: true
    end
  end
end
