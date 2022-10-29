class CreateStudent < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :uni, unique: true
      t.string :name
    end
  end
end
