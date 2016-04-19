class Note < ActiveRecord::Base
	has_many :note_question_joints
	has_many :questions, :through => :note_question_joints
end
