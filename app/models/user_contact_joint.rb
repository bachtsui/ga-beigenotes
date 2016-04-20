class UserContactJoint < ActiveRecord::Base
	#Joint Many to Many table for User and Contacts
	belongs_to :user
	belongs_to :contact 
end
