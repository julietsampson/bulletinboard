class CreateStudent < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.text :uni, unique: true
      t.text :name
    end
  end
end
