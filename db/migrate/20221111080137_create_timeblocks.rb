class CreateTimeblocks < ActiveRecord::Migration[6.1]
  def change
    create_table :timeblocks do |t|
      t.tsrange :busy_range

      t.timestamps
    end
  end
end
