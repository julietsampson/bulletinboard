class AddReferencesToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :organizer, index: true, foreign_key: true
  end
end
