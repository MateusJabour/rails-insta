class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"


  def createNotification
    @user = self.follower
    @notified_user = self.followed

    @notification = Notification.new()

    @notification.user_id = @user.id
    @notification.notified_user_id = @notified_user.id
    @notification.text = @user.username + ' is following you'
    @notification.subject = 'relationship'
    @notification.target_id = @user.id

    unless @notification.save
      puts "Error"
    end
  end
end
