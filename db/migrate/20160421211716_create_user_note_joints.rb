class CreateUserNoteJoints < ActiveRecord::Migration
  def change
    create_table :user_note_joints do |t|

      t.timestamps null: false

      t.references :user
      t.references :note
    end
  end
end
