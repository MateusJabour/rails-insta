class User < ApplicationRecord
  has_secure_password

  has_many :photos
  has_many :comments
  has_many :likes

  has_many :relationships, class_name:  "Relationship", foreign_key: "follower_id",
            dependent: :destroy
  has_many :following, through: :relationships, source: :followed

  has_attached_file :avatar, styles: { small: "150x150>", thumb: "38x38>" }, default_url: "/assets/missing_avatar_:style.jpg"

  validates_presence_of :username
  validates_email_format_of :email
  validates_uniqueness_of :email, :username
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
