class AddReferencesToEvents < ActiveRecord::Migration[6.1]
  def change
    add_reference :events, :organizer, index: true, foreign_key: true
  end
end
