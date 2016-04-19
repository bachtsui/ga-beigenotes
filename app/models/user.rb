class User < ActiveRecord::Base
	validates :email, presence: true, uniqueness: true,
  	format: { with: /[^@\s]+@(?:[-a-z0-9]+\.)+[a-z]{2,}/i,
            message: 'format is invalid'}
  #Regex used to check if email has an @ symbol in it

  validates :password, length: { in: 6...255},
             :on => :create
        
  #Created a separate validation for edit from to allow
  #for password field to be blank         
  validates :password, length: { in: 6...255},
             :on => :update,
             allow_blank: true     

  has_secure_password
  include FriendlyId
  friendly_id :last_name,:use => [:slugged]
  
  #Use for FriendlyId         
  # extend FriendlyId
  # friendly_id :name, use: :slugged
end
