class SignupController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    data = {}

    if @user.save
      session[:user_id] = @user.id
      data[:redirect] = user_page_path(session[:user_id])
    else
      data[:errors] = @user.errors
    end

    respond_to do |format|
      format.html
      format.json { render json: data }
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
