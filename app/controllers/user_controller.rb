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

  def change_password
    old_password = params[:user][:old_password]
    new_password = params[:user][:password]
    message = ''

    if new_password == old_password
      message = 'You\'re already using this password, put a different one.'
    elsif current_user.authenticate(old_password)
      if current_user.update(change_password_params)
        message = 'Your password was changed successfully'
      else
        if new_password != params[:user][:password_confirmation]
          message = 'Password confirmation is different from password.'
        else
          message = 'Something happened'
        end
      end
    else
      message = 'Your current password is wrong, re-enter it.'
    end

    respond_to do |format|
      format.html
      format.json { render json: {message: message} }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar, :website, :biography, :gender, :phone_number, :is_private)
  end

  def change_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
