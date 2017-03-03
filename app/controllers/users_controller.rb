class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save!
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.name} !"
      redirect_to root_url
    else
      flash[:error] = "Error #{@user.errors.full_messages.to_sentence}"
      render new_user_path
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
