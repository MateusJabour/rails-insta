module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :logged_in?, :current_user
  end

  private

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    return if logged_in?

    reset_session

    session[:return_to] = request.fullpath if request.get?

    redirect_to login_path, notice: 'You must be logged in to access this page.'
  end
end
