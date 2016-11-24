class User < ApplicationRecord
  has_secure_password
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

  validates_presence_of :username
  validates_email_format_of :email
  validates_uniqueness_of :email, :username
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
