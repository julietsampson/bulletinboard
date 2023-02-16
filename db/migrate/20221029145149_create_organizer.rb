class CreateOrganizer < ActiveRecord::Migration[6.1]
  def change
    create_table :organizers do |t|
      t.text :name
      t.text :email, unique: true
    end
  end
end
