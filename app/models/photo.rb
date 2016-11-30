class Photo < ApplicationRecord
  belongs_to :user

  has_attached_file :image, styles: { large: '600x600>', medium: "293x293>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
