class SessionsController < ApplicationController
  def new
  	@user = User.new
    render :new
  end

  def create
    user_params = params.require(:user).permit(:email, :password)
    @user = User.confirm(user_params)
    if @user
      login(@user)
      flash[:notice] = "Successfully logged in."      # Flash notice for success.
      redirect_to @user
    else
      flash[:error] = "Incorrect email or password."  # Flash notice for error.
      redirect_to new_session_path
    end
  end 

  def destroy
    logout
    flash[:notice] = "Successfully logged out."        # Flash notice for success.
    redirect_to root_path
  end   
end
