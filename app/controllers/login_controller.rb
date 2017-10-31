class LoginController < ApplicationController
  def new
    if session[:user_id]
      redirect_to timeline_path
    end
  end

  def create
    user = User.find_by_username(params[:username].to_s)
    data = {}
    if user && user.authenticate(params[:password])
      return_url = session.fetch(:return_to, user_page_path(user.id))
      reset_session
      session[:user_id] = user.id
      data[:redirect] = return_url
    else
      data[:error] =  'Username or password invalid'
    end

    respond_to do |format|
      format.html
      format.json { render json: data }
    end

  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
