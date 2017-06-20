class LoginController < ApplicationController
  def new
    if session[:user_id]
      redirect_to timeline_path
    end
  end

  def create
    user = User.find_by_username(params[:username].to_s)

    if user && user.authenticate(params[:password])
      return_url = session.fetch(:return_to, user_page_path(user.id))
      reset_session
      session[:user_id] = user.id
      redirect_to return_url
    else
      flash.now.notice = 'Username or password invalid'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'Logged out'
  end
end
