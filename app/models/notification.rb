class Notification < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :notified_user, class_name: "User"
end
