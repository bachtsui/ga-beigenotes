class UsersController < ApplicationController
	before_action :authenticate_user!

	def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
  	@user = User.create(user_params)
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
