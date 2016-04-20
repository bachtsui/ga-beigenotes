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

  #Used by SessionsController Create
  def self.confirm(params)
    @user = User.find_by({email: params[:email]})
    @user.try(:authenticate, params[:password])
  end  

  # One to Many Association for User and Notes
  has_many :notes

  # Many to Many Association with Users and Contacts
  has_many :user_contact_joints
  has_many :contacts, :through => :user_contact_joints
end
