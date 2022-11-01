class CreateEvent < ActiveRecord::Migration[6.1.2]
  def change
    create_table :events do |t|
      t.text :name
      t.datetime :datetime
      t.text :location
      t.text :description
      t.text :tags, array: true, default: []
    end
  end
end
