class Comment < ApplicationRecord
  belongs_to :photo
  belongs_to :user

  validates_presence_of :text
end
