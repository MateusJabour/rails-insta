class Comment < ApplicationRecord
  belongs_to :photo
  belongs_to :user

  validates_presence_of :text

  def createNotification
    @user = self.user
    @notified_user = self.photo.user

    @notification = Notification.new()

    @notification.user_id = @user.id
    @notification.notified_user_id = @notified_user.id
    @notification.text = @user.username + ' commented your photo: ' + self.text
    @notification.subject = 'comment'
    @notification.target_id = self.photo.id

    unless @notification.save
      puts "Error"
    end
  end
end
