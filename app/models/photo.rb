class Photo < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  has_attached_file :image, styles: { large: '600x600>', medium: "293x293>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def isLikedByUser(user)
    !(self.likes.index { |like| like.user_id == user.id }.nil?)
  end
end
