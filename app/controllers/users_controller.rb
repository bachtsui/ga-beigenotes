class UsersController < ApplicationController
  before_action :logged_in?, only: [:show, :edit, :update] 

  #For Twilio Messaging
  def twilio_client
    Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  def send_message
    @user = current_user
    twilio_client.messages.create(
      to: @user.contacts.last.number,
      from: ENV['TWILIO_PHONE_NUMBER'],
      body: "Hey #{@user.contacts.last.name}:

#{@user.first_name} from #{@user.contacts.last.location} has just filled out some questions about your date.

Here’s a snippet of what your date had to say:

“#{Note.last.aone}”

To see what else they had to say:
1. Click on this link to sign up/login to BeigeNotes https://afternoon-basin-78472.herokuapp.com/onboard\n
2. Answer the same questions about your date to see what else they had to say. It will only take about 2 mins. Click here to answer
https://afternoon-basin-78472.herokuapp.com/users/#{current_user.id}/notes/#{Note.last.id}/edit

Best,
Cindy
Beige Notes" 

      # Try Beigenotes: https://afternoon-basin-78472.herokuapp.com/onboard\n Here's a note for you to respond to\n 
      # https://afternoon-basin-78472.herokuapp.com/users/#{current_user.id}/notes/#{Note.last.id}/edit"
    )
  end

  #Need a way for the original sender to get notified
  #We need to make a note helper function
  def respond_message
    @user = current_user
    @note = @user.note.last
    twilio_client.messages.create(
      to: @note.users.first.phone_number,
      from: ENV['TWILIO_PHONE_NUMBER'],
      body: "Your note was completed!\n 
      https://afternoon-basin-78472.herokuapp.com/users/#{current_user.id}/notes/#{Note.last.id}/"
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
    @notes = @user.notes
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


  #Method for Contact
  def new_contact
    @user = User.friendly.find(params[:id])
    @contact = Contact.new
    render :form
  end

  #Methods for Note
  def new_note
    @note = Note.new
    render :note
  end

  def create_note
    @note = Note.create(note_params)
    @user = current_user
    @note.pending = true
    @note.save
    @user.notes << @note
    send_message
    redirect_to "/users/#{current_user.slug}"
  end

  def complete_note
    @user = current_user
    @notes = @user.notes
    render :completed_notes
  end

  def pending_note
    @user = current_user
    @notes = @user.notes
    render :pending_notes
  end

  def show_note
    @note = Note.find_by_id(params[:nid])
    render :show_note
  end

  def edit_note
    @note = Note.find_by_id(params[:nid])
    render :edit_note
  end

  def update_note
    @user = current_user
    @note = Note.find_by_id(params[:nid])
    @note.update(notetwo_params)
    @note.completed = true
    @note.pending = false
    @note.save
    @user.notes << @note
    respond_message
    #Add note to the reciever of the note
    redirect_to user_path(@user)
  end

  def onboard
    render :onboard
  end

  def display
    render :instruction
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :username, :password, :password_confirmation)
  end

  def note_params
    params.require(:note).permit(:aone, :atwo, :athree, :afour, :afive, :asix)
  end

  def notetwo_params
    params.require(:note).permit(:paone, :patwo, :pathree, :pafour, :pafive, :pasix)
  end

  def set_user
    user_id = params[:id] || current_user.id
    @user = User.friendly.find(user_id)
  end
end
