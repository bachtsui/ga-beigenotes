class Question < ActiveRecord::Base
	has_many :note_question_joints
	has_many :notes, :through => :note_question_joints
end
