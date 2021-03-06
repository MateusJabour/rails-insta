class TimelineController < ApplicationController
  before_action :require_login
  
  def index
  	@user = User.find_by_id(session[:user_id])
    @photos = []

    @photos += @user.photos
    @user.followings.each { |following|
      @photos += following.photos
    }
  end
end
