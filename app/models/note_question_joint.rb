class NoteQuestionJoint < ActiveRecord::Base
	belongs_to :note
	belongs_to :question
end
