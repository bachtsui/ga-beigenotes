class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.boolean :pending
      t.boolean :completed
      t.integer :limit

      t.timestamps null: false
    end
  end
end
