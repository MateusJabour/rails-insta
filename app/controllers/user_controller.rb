class UserController < ApplicationController
  def index
    @user = User.find_by_id(params[:id])
  end

  def list
    @all_user = User.all
  end

  def edit
    @user = User.find_by_id(session[:user_id])
  end

  def update
    @user = User.find_by_id(session[:user_id])
    @user.update(user_params)
    flash.now.alert = 'Profile updated'
    render :edit
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar, :website, :biography, :gender, :phone_number)
  end
end
