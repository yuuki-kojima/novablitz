class Post < ApplicationRecord
  mount_uploader :image, ImagesUploader
  enum category: { beginner: 1 }
  enum publish:{ nopublish: 0, published: 1 }

  ALLOWED_PARAMS = [:id, :title, :category, :image, :text, :friendly_id_slugs, :publish]

  validates :title, presence: true
  validates :category, presence: true
  validates :text, presence: true

  include FriendlyId
  friendly_id :friendly_id_slugs

end
