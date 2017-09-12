class NotificationController < ApplicationController
  def index
    @notifications = Notification.all.where(:notified_user => current_user.id)
  end
end
