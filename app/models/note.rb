class Note < ActiveRecord::Base

	# Many to Many Relationship between Notes and Questions
	has_many :note_question_joints
	has_many :questions, :through => :note_question_joints

	# Many to Many to Users
	has_many :user_note_joints
  has_many :users, :through => :user_note_joints
end
