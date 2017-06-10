class User < ApplicationRecord
  has_secure_password

  has_many :photos
  has_many :comments
  has_many :likes

  has_many :following_relationships, class_name:  "Relationship",
                            foreign_key: "follower_id",
                            dependent:   :destroy

  has_many :follower_relationships, class_name:  "Relationship",
                            foreign_key: "followed_id",
                            dependent:   :destroy

  has_many :followings, class_name: 'User', through: :following_relationships, source: :followed
  has_many :followers, class_name: 'User', through: :follower_relationships, source: :follower

  has_attached_file :avatar, styles: { small: "150x150>", thumb: "38x38>" }, default_url: "/assets/missing_avatar_:style.jpg"

  validates_presence_of :username
  validates_email_format_of :email
  validates_uniqueness_of :email, :username
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
