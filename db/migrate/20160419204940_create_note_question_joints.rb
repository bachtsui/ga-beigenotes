class CreateNoteQuestionJoints < ActiveRecord::Migration
  def change
    create_table :note_question_joints do |t|

      t.timestamps null: false

      t.references :note
      t.references :question 
    end
  end
end
