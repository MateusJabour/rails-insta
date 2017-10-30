class NotificationController < ApplicationController
  before_action :require_login

  def index
    @notifications = Notification.all.where(:notified_user => current_user.id)
    @pending_followeds = current_user.pending_follower_relationships
  end
end
