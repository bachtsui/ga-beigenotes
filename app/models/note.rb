class Note < ActiveRecord::Base

	# Many to Many Relationship between Notes and Questions
	has_many :note_question_joints
	has_many :questions, :through => :note_question_joints

	# Many to One to Users
	belongs_to :user 
end
