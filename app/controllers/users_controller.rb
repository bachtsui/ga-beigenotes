class UsersController < ApplicationController
  before_action :logged_in?, only: [:show, :edit, :update] 

  #For Twilio Messaging
  def twilio_client
    Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  def send_message
    #p Contact.last.number
    #@user.contact.last.number
    twilio_client.messages.create(
      to: Contact.last.number,
      from: ENV['TWILIO_PHONE_NUMBER'],
      body: "Testing"
    )
  end

	def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
  	@user = User.new(user_params)

    if @user.save
      login(@user) 
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def show
    @user = User.friendly.find(params[:id])
  end

  def edit
    if current_user == set_user
      render :edit
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "Successfully Updated Profile"
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      redirect_to edit_user_path(@user)
    end
  end

  def destroy
    @user = User.friendly.find(params[:id])
    if current_user == @user
      @user.destroy
      flash[:notice] = "Successfully deleted user #{@user.last_name}"
      redirect_to root_path
    else
      flash[:notice] = "You can't delete that user."
      redirect_to user_path(@user)
    end
  end

  #METHOD for Contact
  # def contact
  # end
  

  #CR for Notes
  #Can we delete notes

  #Create for notes
  def new_contact
    @user = User.friendly.find(params[:id])
    @contact = Contact.new 
    # @user.first_name.clear
    # @user.phone_number.clear
    render :form
    #redirect_to new_note_path(@user)
  end

  def new_note
    @note = Note.new
    render :note
  end

  def create_note
    @note = Note.create(note_params)
    send_message
    redirect_to "/users/#{current_user.slug}"

    #Need to add twilio functionality
  end

  def show_note
    #READ for notes
  end

  #def edit_note
    #UPDATE for notes
  #end

  #def update_note 
    #UPDATE for notes
  #end

  #These methods are used for Twilio


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :username, :password, :password_confirmation)
  end

  def note_params
    params.require(:note).permit(:aone, :atwo)
  end

  def set_user
    user_id = params[:id] || current_user.id
    @user = User.friendly.find(user_id)
  end
end
