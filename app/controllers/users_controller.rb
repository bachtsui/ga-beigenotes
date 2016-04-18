class UsersController < ApplicationController
	before_action :authenticate_user!

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
    @user = User.find_by_id(params[:id])
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :username, :password, :password_confirmation)
  end
end
