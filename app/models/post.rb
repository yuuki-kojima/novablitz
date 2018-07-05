class Post < ApplicationRecord
  mount_uploader :image, ImagesUploader
  enum category: { beginner: 1 }

  ALLOWED_PARAMS = [:id, :title, :category, :image, :text]

  validates :title, presence: true
  validates :category, presence: true
  validates :text, presence: true
end
