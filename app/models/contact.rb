class Contact < ActiveRecord::Base
	#Many to Many Relationships for Users
	has_many :user_contact_joints
	has_many :users, :through => :user_contact_joints
end
