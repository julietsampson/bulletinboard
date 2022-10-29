class CreateEvent < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :datetime
      t.string :location
      t.text :description
      t.string :tags, array: true, default: []
    end
  end
end
